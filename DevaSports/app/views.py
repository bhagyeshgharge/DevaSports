from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse
from django.contrib import messages
from django.contrib.auth import authenticate, login as auth_login, logout
from django.contrib.auth.hashers import make_password
from django.contrib.auth import get_user_model
from django.views.decorators.csrf import csrf_exempt
from .models import *
from django.db import transaction
import json
from .models import CustomUser  # Assuming you're using a custom user model
from .forms import EmailForm
from .utils import generate_otp, send_otp_email

 





# Home - Product Card List
def product_card(request):
    product_cards = []
    variants = ProductVariant.objects.select_related(
        'product', 'product__brand', 'product__category'
    ).prefetch_related('sizes').all()

    for variant in variants:
        image_obj = getattr(variant, 'images', None)
        product_image = image_obj.image1.url if image_obj and image_obj.image1 else '/static/images/default.png'

        # Get first size and price if available
        first_size = variant.sizes.first()

        product_cards.append({
            'product': variant.product,
            'variant': variant,
            'product_image': product_image,
            'first_size': first_size,
        })

    brands = Brand.objects.all()
    return render(request, 'home.html', {'product_cards': product_cards,'brands': brands })


from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.shortcuts import render, redirect

def login_view(request):
    if request.method == "POST":
        email = request.POST.get("email")
        password = request.POST.get("password")
        next_url = request.POST.get("next") or "/"

        user = authenticate(request, email=email, password=password)
        if user is not None:
            auth_login(request, user)
            return JsonResponse({
                "status": "success",
                "message": "Login successful!",
                "redirect_url": next_url
            })
        else:
            return JsonResponse({
                "status": "error",
                "message": "Invalid email or password."
            })

    context = {"next": request.GET.get("next", "/")}
    return render(request, 'login.html', context)


def LogOut(request):
     logout(request)
     return redirect('/')

User = get_user_model()
def Forgot_password(request):
    if request.method == "POST":
        action = request.POST.get("action")
        email = request.POST.get("email")

        if action == "send_otp":
            if not User.objects.filter(email=email).exists():
                return JsonResponse({
                    "status": "error",
                    "message": "This email is not registered."
                })

            otp = generate_otp()
            request.session['reset_email'] = email
            request.session['reset_otp'] = otp
            send_otp_email(email, otp, purpose="reset")

            return JsonResponse({
                "status": "success",
                "message": "OTP sent to your email."
            })

        elif action == "verify_otp":
            entered_otp = request.POST.get("otp")
            session_otp = request.session.get("reset_otp")

            if entered_otp == session_otp:
                return redirect('reset_password')  # URL name for your reset password page

            return render(request, "forget_password.html", {
                "error": "Invalid OTP. Please try again."
            })

    return render(request, "forget_password.html")


def reset_password(request):
    if request.method == "POST":
        password = request.POST.get("new_password")  # 🔄 Match form input name
        confirm_password = request.POST.get("confirm_password")
        email = request.session.get("reset_email")

        if not email:
            messages.error(request, "Session expired. Please request a new OTP.")
            return redirect("forgot_password")

        if not password or not confirm_password:
            messages.error(request, "Both password fields are required.")
            return render(request, "reset_password.html")

        if password != confirm_password:
            messages.error(request, "Passwords do not match.")
            return render(request, "reset_password.html")

        if len(password) < 6:
            messages.error(request, "Password must be at least 6 characters long.")
            return render(request, "reset_password.html")

        try:
            user = User.objects.get(email=email)
            user.set_password(password)
            user.save()

            request.session.pop("reset_email", None)
            request.session.pop("reset_otp", None)

            messages.success(request, "Password updated successfully! Please log in.")
            return redirect("login")

        except User.DoesNotExist:
            messages.error(request, "User not found.")
            return redirect("forgot_password")

    return render(request, "reset_password.html")


@csrf_exempt
def signup(request):
    if request.method == "POST":
        action = request.POST.get("action")

        # ---------- Step 1: SEND OTP ----------
        if action == "send_otp":
            email = request.POST.get("email")

            if not email:
                return JsonResponse({"status": "error", "message": "Please enter your email."})

            if CustomUser.objects.filter(email=email).exists():
                return JsonResponse({"status": "error", "message": "This email is already registered."})

            otp = generate_otp()
            request.session['otp'] = otp
            request.session['otp_email'] = email

            send_otp_email(email, otp, "signup")
            return JsonResponse({"status": "success", "message": "OTP has been sent to your email."})

        elif action == "signup":
            full_name = request.POST.get("name", "").strip().title()
            email = request.POST.get("email")
            password = request.POST.get("password")
            otp_input = request.POST.get("otp")

            if not all([full_name, email, password, otp_input]):
                return JsonResponse({"status": "error", "message": "All fields are required."})

            session_otp = request.session.get("otp")
            session_email = request.session.get("otp_email")

            if session_email != email or session_otp != otp_input:
                return JsonResponse({"status": "error", "message": "Invalid OTP or email."})

            if CustomUser.objects.filter(email=email).exists():
                return JsonResponse({"status": "error", "message": "This email is already registered."})

            try:
                first_name = full_name
                last_name = ""

                if " " in full_name:
                    parts = full_name.split()
                    first_name = parts[0]
                    last_name = " ".join(parts[1:])

                user = CustomUser.objects.create(
                    first_name=first_name,
                    last_name=last_name,
                    email=email,
                    password=make_password(password),
                    is_active=True
                )
                auth_login(request, user)
                request.session.pop("otp", None)
                request.session.pop("otp_email", None)

                return JsonResponse({
                    "status": "success",
                    "message": "Signup successful!",
                    "redirect_url": "/"
                })

            except Exception as e:
                return JsonResponse({
                    "status": "error",
                    "message": "Something went wrong. Please try again."
                })

    return render(request, 'signup.html')


def add_product(request):
    colors = Color.objects.all()
    categories = Category.objects.all()
    brands = Brand.objects.all()
    sizes = Size.objects.all()

    if request.method == 'POST':
        try:
            with transaction.atomic():
                # Collect product data
                name = request.POST.get('product_name')
                description = request.POST.get('description')
                is_active = bool(request.POST.get('activate'))
                
                category = Category.objects.get(name=request.POST.get('category'))
                brand = Brand.objects.get(name=request.POST.get('brand'))
                color = Color.objects.get(name=request.POST.get('color'))

                # Create product
                product = Product.objects.create(
                    name=name,
                    brand=brand,
                    category=category,
                    description=description,
                    is_active=is_active
                )

                # Create variant
                sku = f"{product.name[:3].upper()}-{color.name[:3].upper()}-{product.id}"
                variant = ProductVariant.objects.create(
                    product=product,
                    color=color,
                    sku=sku
                )

                # Sizes, prices, stocks
                size_labels = request.POST.getlist('size[]')
                prices = request.POST.getlist('price[]')
                stocks = request.POST.getlist('stock[]')

                for s_label, price, stock in zip(size_labels, prices, stocks):
                    size = Size.objects.get(size_label=s_label)
                    ProductVariantSize.objects.create(
                        variant=variant,
                        size=size,
                        price=price,
                        stock=stock
                    )

                # Images
                ProductVariantImage.objects.create(
                    variant=variant,
                    image1=request.FILES.get('image1'),
                    image2=request.FILES.get('image2'),
                    image3=request.FILES.get('image3'),
                    image4=request.FILES.get('image4')
                )

                messages.success(request, "Product added successfully!")
                return redirect('home')  # Replace 'home' with your homepage name

        except Exception as e:
            messages.error(request, f"Error saving product: {str(e)}")

    return render(request, 'add_product.html', {
        'categories': categories,
        'brands': brands,
        'colors': colors,
        'sizes': sizes,
    })


@csrf_exempt
def savedetails_card(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            variant_id = data.get('id')
            quantity = int(data.get('quantity', 1))

            if not variant_id:
                return JsonResponse({'error': 'Invalid variant ID'}, status=400)

            variant = get_object_or_404(ProductVariant, id=variant_id)

            # 🟡 Get first available size
            first_size_relation = variant.sizes.select_related('size').first()
            if not first_size_relation:
                return JsonResponse({'error': 'No sizes available for this variant'}, status=400)

            size_instance = first_size_relation.size
            color_instance = variant.color

            # 🟠 Get or create Cart: prefer user cart
            if request.user.is_authenticated:
                cart, _ = Cart.objects.get_or_create(user=request.user)
            else:
                session_key = request.session.session_key
                if not session_key:
                    request.session.create()
                    session_key = request.session.session_key
                cart, _ = Cart.objects.get_or_create(session_key=session_key)

            # 🟤 Get/Create CartItem
            item, created = CartItem.objects.get_or_create(
                cart=cart,
                product_variant=variant,
                size=size_instance,
                color=color_instance,
                defaults={'quantity': quantity}
            )

            if not created:
                item.quantity += quantity
                item.save()
                return JsonResponse({'message': 'Cart updated with more quantity!'})

            return JsonResponse({'message': 'Product added to cart successfully!'})

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=400)

    return JsonResponse({'error': 'Invalid request method'}, status=400)


from django.db.models import Prefetch

def product_details(request, variant_id):
    variant = get_object_or_404(ProductVariant, id=variant_id)
    product = variant.product
    images = getattr(variant, 'images', None)
    sizes = variant.sizes.select_related('size')
    other_variants = product.variants.exclude(id=variant.id).select_related('color')

    # ✅ Show stock to admin or custom users
    show_stock = False
    if request.user.is_authenticated and (request.user.is_superuser or getattr(request.user, 'is_custom_user', False)):
        show_stock = True

    # ✅ Get similar products
    similar_variants = ProductVariant.objects.filter(
        product__category=product.category
    ).exclude(
        id=variant.id
    ).select_related(
        'product', 'color'
    ).prefetch_related(
        Prefetch('sizes', queryset=ProductVariantSize.objects.select_related('size'))
    )[:10]

    # ✅ Add to Cart POST Handler
    if request.method == 'POST' and request.POST.get('action') == 'cart-btn':
        selected_size_name = request.POST.get('selected_size')
        quantity = int(request.POST.get('quantity', 1))

        size_instance = Size.objects.filter(size_label=selected_size_name).first()
        if not size_instance:
            return JsonResponse({'success': False, 'error': 'Invalid size selected'})

        color_instance = variant.color

        # ✅ Create/get cart based on login or session
        if request.user.is_authenticated:
            cart, _ = Cart.objects.get_or_create(user=request.user)
        else:
            session_key = request.session.session_key
            if not session_key:
                request.session.create()
                session_key = request.session.session_key
            cart, _ = Cart.objects.get_or_create(session_key=session_key)

        # ✅ Add or update item
        cart_item = CartItem.objects.filter(
            cart=cart,
            product_variant=variant,
            size=size_instance,
            color=color_instance
        ).first()

        if cart_item:
            cart_item.quantity += quantity
            cart_item.save()
            message = "Cart updated with more quantity!"
        else:
            CartItem.objects.create(
                cart=cart,
                product_variant=variant,
                size=size_instance,
                color=color_instance,
                quantity=quantity
            )
            message = "Product added to cart successfully!"

        return JsonResponse({'success': True, 'message': message})

    # ✅ Final context
    return render(request, 'product_details.html', {
        'product': product,
        'variant': variant,
        'sizes': sizes,
        'images': images,
        'other_variants': other_variants,
        'show_stock': show_stock,
        'similar_variants': similar_variants
    })



@csrf_exempt
def submit_review(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            variant_id = data.get("variant_id")
            name = data.get("name")
            email = data.get("email", "")
            title = data.get("title")
            comment = data.get("comment")
            rating = int(data.get("rating"))

            if not (variant_id and name and title and comment and rating):
                return JsonResponse({"success": False, "message": "Missing fields."}, status=400)

            variant = ProductVariant.objects.get(id=variant_id)

            ProductReview.objects.create(
                variant=variant,
                name=name,
                email=email,
                title=title,
                comment=comment,
                rating=rating
            )

            return JsonResponse({"success": True, "message": "Review submitted!"})
        except Exception as e:
            return JsonResponse({"success": False, "message": str(e)}, status=500)

    return JsonResponse({"success": False, "message": "Invalid request."}, status=405)





@csrf_exempt
def add_to_card(request):
    # ✅ Use authenticated user's cart if logged in
    if request.user.is_authenticated:
        cart, _ = Cart.objects.get_or_create(user=request.user)
    else:
        # Fallback to session-based cart
        session_key = request.session.session_key
        if not session_key:
            request.session.create()
            session_key = request.session.session_key
        cart, _ = Cart.objects.get_or_create(session_key=session_key)

    if request.method == 'POST':
        action = request.POST.get('action')
        item_id = request.POST.get('item_id')

        if not item_id or not action:
            return JsonResponse({'success': False, 'error': 'Invalid data'})

        try:
            item = CartItem.objects.get(id=item_id, cart=cart)
        except CartItem.DoesNotExist:
            return JsonResponse({'success': False, 'error': 'Item not found'})

        if action == 'remove':
            item.delete()
            return JsonResponse({'success': True, 'message': 'Item removed'})

        elif action == 'update_qty':
            try:
                change = int(request.POST.get('change', 0))

                size_relation = ProductVariantSize.objects.filter(
                    variant=item.product_variant,
                    size=item.size
                ).first()

                if not size_relation:
                    return JsonResponse({'success': False, 'error': 'Stock data not found'})

                new_quantity = item.quantity + change

                if new_quantity > size_relation.stock:
                    return JsonResponse({'success': False, 'error': f'Only {size_relation.stock} in stock'})

                if item.quantity == 1 and change == -1:
                    item.delete()
                    return JsonResponse({'success': True, 'deleted': True})
                elif new_quantity >= 1:
                    item.quantity = new_quantity
                    item.save()
                    return JsonResponse({'success': True, 'quantity': item.quantity})
                else:
                    return JsonResponse({'success': False, 'message': 'Minimum quantity is 1'})

            except Exception:
                return JsonResponse({'success': False, 'error': 'Invalid quantity'})

    # For GET request → show cart page
    cart_items = cart.items.select_related(
        'product_variant__product',
        'product_variant__product__brand'
    ).all() if cart else []

    return render(request, 'add_to_card.html', {'cart_items': cart_items})




def category_products(request, slug):
    category = get_object_or_404(Category, name__iexact=slug.replace('-', ' '))

    product_cards = ProductVariant.objects.filter(
        product__category=category
    ).select_related(
        'product', 'product__brand', 'color'
    ).prefetch_related(
        Prefetch('sizes', queryset=ProductVariantSize.objects.select_related('size')),
        'images'
    )

    return render(request, 'category.html', {
        'category': category,
        'product_cards': product_cards,
    })




# Get cart count (for badge update)
def cart_count(request):
    if request.user.is_authenticated:
        # Logged-in user cart
        cart = Cart.objects.filter(user=request.user).first()
    else:
        # Session-based cart
        session_key = request.session.session_key
        if not session_key:
            return JsonResponse({'count': 0})
        cart = Cart.objects.filter(session_key=session_key).first()

    count = cart.items.count() if cart else 0
    return JsonResponse({'count': count})


def otp(request):
    return render(request, 'otp.html')

from django.shortcuts import get_object_or_404
from app.models import ProductVariant, ProductVariantSize, Size

def buy_process(request):
    variant_id = request.GET.get('variant_id')
    size_label = request.GET.get('size')
    price = request.GET.get('price')
    quantity = request.GET.get('quantity')

    if not all([variant_id, size_label, price, quantity]):
        return render(request, 'buy_process.html', {'error': 'Incomplete product information.'})

    try:
        quantity = int(quantity)
        price = float(price)
    except ValueError:
        return render(request, 'buy_process.html', {'error': 'Invalid price or quantity.'})

    # Get objects
    variant = get_object_or_404(ProductVariant.objects.select_related('product', 'color', 'images'), id=variant_id)
    size = get_object_or_404(Size, size_label=size_label)

    # Get stock from ProductVariantSize
    variant_size = ProductVariantSize.objects.filter(variant_id=variant_id, size_id=size.id).first()
    stock = variant_size.stock if variant_size else 0

    # Limit initial quantity to stock
    if quantity > stock:
        quantity = stock

    subtotal = price * quantity
    total = subtotal

    context = {
        'item': {
            'product_name': variant.product.name,
            'color': variant.color.name if variant.color else "N/A",
            'size': size_label,
            'price': price,
            'quantity': quantity,
            'stock': stock,  # ✅ pass this to template
            'total': subtotal,
            'image_url': variant.images.image1.url if variant.images and variant.images.image1 else '/static/images/default.png',
        },
        'subtotal': subtotal,
        'total_amount': total,
    }

    return render(request, 'buy_process.html', context)

