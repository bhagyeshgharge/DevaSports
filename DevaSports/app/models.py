from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.db import models
from django.conf import settings
from django.utils import timezone
import uuid

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError("Email must be provided")

        email = self.normalize_email(email)
        extra_fields['email'] = email

        user = self.model(**extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if not email:
            raise ValueError("Superuser must have an email.")
        if not password:
            raise ValueError("Superuser must have a password.")

        return self.create_user(email=email, password=password, **extra_fields)


class CustomUser(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30, blank=True)

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['first_name']

    def __str__(self):
        return self.email



class Category(models.Model):
    name = models.CharField(max_length=100, unique=True)
    image = models.ImageField(upload_to='product_images/', blank=True, null=True)
    def __str__(self): return self.name


class Brand(models.Model):
    name = models.CharField(max_length=100, unique=True)
    def __str__(self): return self.name


class Product(models.Model):
    name = models.CharField(max_length=150)
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE, related_name='products')
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name='products')
    description = models.TextField(blank=True)
    # base_price = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    is_active = models.BooleanField(default=True)
    is_arrival=models.BooleanField(default=False)

    def __str__(self):
        return f"{self.name} ({self.brand.name}) - {self.category.name}"


class Color(models.Model):
    name = models.CharField(max_length=50, unique=True)
    def __str__(self): return self.name


class Size(models.Model):
    size_label = models.CharField(max_length=50, unique=True)
    def __str__(self): return self.size_label


class ProductVariant(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='variants')
    color = models.ForeignKey(Color, on_delete=models.CASCADE)
    sku = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return f"{self.product.name} - {self.color.name}"


class ProductVariantSize(models.Model):
    variant = models.ForeignKey(ProductVariant, on_delete=models.CASCADE, related_name='sizes')
    size = models.ForeignKey(Size, on_delete=models.CASCADE)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.PositiveIntegerField(default=0)

    class Meta:
        unique_together = ('variant', 'size')

    def __str__(self):
        return f"{self.variant} - {self.size.size_label}"


class ProductVariantImage(models.Model):
    variant = models.OneToOneField(ProductVariant, on_delete=models.CASCADE, related_name='images')
    image1 = models.ImageField(upload_to='product_images/', blank=True, null=True)
    image2 = models.ImageField(upload_to='product_images/', blank=True, null=True)
    image3 = models.ImageField(upload_to='product_images/', blank=True, null=True)
    image4 = models.ImageField(upload_to='product_images/', blank=True, null=True)

    def __str__(self):
        return f"Images for {self.variant}"
    
class Cart(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, null=True, blank=True
    )
    session_key = models.CharField(max_length=40, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        if self.user:
            return f"Cart (User: {self.user.email})"
        return f"Cart (Session: {self.session_key})"


class CartItem(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name='items')
    product_variant = models.ForeignKey('app.ProductVariant', on_delete=models.CASCADE)
    size = models.ForeignKey(Size, on_delete=models.CASCADE)  # Required if using size
    color = models.ForeignKey('app.Color', on_delete=models.CASCADE)  # ✅ New color field
    quantity = models.PositiveIntegerField(default=1)

    def __str__(self):
        return f"{self.product_variant} - {self.color.name} - {self.size.size_label} x {self.quantity}"
    

class ProductReview(models.Model):
    variant = models.ForeignKey('ProductVariant', on_delete=models.CASCADE, related_name='reviews')
    name = models.CharField(max_length=100)  # Public display name
    email = models.EmailField()              # Private, not displayed
    title = models.CharField(max_length=150) # Title of the review
    comment = models.TextField()
    rating = models.PositiveIntegerField(default=0)  # From 1 to 5
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.name} - {self.rating}★ - {self.variant.product.name}"
    

class Order(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.SET_NULL,
        null=True, blank=True  # Blank for guest users
    )

    # Guest user fields
    guest_name = models.CharField(max_length=100, blank=True, null=True)
    guest_email = models.EmailField(blank=True, null=True)
    guest_phone = models.CharField(max_length=15, blank=True, null=True)

    # Shipping info
    address = models.TextField()
    city = models.CharField(max_length=100)
    pincode = models.CharField(max_length=10)
    state = models.CharField(max_length=100)
    country = models.CharField(max_length=100)

    # Order meta
    order_id = models.CharField(max_length=20, unique=True, editable=False)
    order_token = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, default='Pending')  # e.g., Pending, Shipped, Delivered
    created_at = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):
        if not self.order_id:
            self.order_id = f'DEVA{uuid.uuid4().hex[:8].upper()}'
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Order {self.order_id} - {'Guest' if not self.user else self.user.email}"


class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name='items', on_delete=models.CASCADE)
    product_variant = models.ForeignKey('app.ProductVariant', on_delete=models.SET_NULL, null=True)
    size = models.ForeignKey('app.Size', on_delete=models.SET_NULL, null=True)
    color = models.ForeignKey('app.Color', on_delete=models.SET_NULL, null=True)
    quantity = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)  # Save price at time of order

    def __str__(self):
        return f"{self.product_variant.product.name} ({self.color.name}, {self.size.size_label}) x {self.quantity}"
