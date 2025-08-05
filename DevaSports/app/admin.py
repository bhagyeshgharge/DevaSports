from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import * 


# class CustomUserAdmin(UserAdmin):
#     model = CustomUser
#     list_display = ['email', 'mobile', 'first_name', 'is_staff']
#     fieldsets = UserAdmin.fieldsets + (
#         (None, {'fields': ('mobile',)}),
#     )
#     add_fieldsets = UserAdmin.add_fieldsets + (
#         (None, {'fields': ('mobile',)}),
#     )

# admin.site.register(CustomUser, CustomUserAdmin)

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name','image')
    search_fields = ('name',)


@admin.register(Brand)
class BrandAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')
    search_fields = ('name',)


@admin.register(Color)
class ColorAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')
    search_fields = ('name',)


@admin.register(Size)
class SizeAdmin(admin.ModelAdmin):
    list_display = ('id', 'size_label')
    search_fields = ('size_label',)


# ✅ Inline for ProductVariantSize under ProductVariant
class ProductVariantSizeInline(admin.TabularInline):
    model = ProductVariantSize
    extra = 3
    autocomplete_fields = ['size']
    fields = ('size', 'price', 'stock')


# ✅ Main ProductVariant admin (Product + Color)
@admin.register(ProductVariant)
class ProductVariantAdmin(admin.ModelAdmin):
    list_display = ('id', 'product', 'color', 'sku')
    list_filter = ('product', 'color')
    search_fields = ('product__name', 'sku')
    inlines = [ProductVariantSizeInline]


# ✅ ProductVariantImage admin
@admin.register(ProductVariantImage)
class ProductVariantImageAdmin(admin.ModelAdmin):
    list_display = ('id', 'variant')


# ✅ Product admin (no inline needed for variants here anymore)
@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'brand', 'category', 'is_active')
    list_filter = ('brand', 'category', 'is_active','is_arrival')
    search_fields = ('name', 'description')
