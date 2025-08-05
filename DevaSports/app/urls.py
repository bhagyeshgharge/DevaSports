from django.conf import settings
from django.conf.urls.static import static
from django.urls import path
from . import views

urlpatterns = [
    path('', views.product_card, name='home'), 
    # path('header/', views.header, name='header'), # Show product cards on home
    path('login',views.login_view, name='login'),
    path('logout',views.LogOut, name='logout'),
    path('forgot_password',views.Forgot_password, name="forgot_password"),
    path('reset_password',views.reset_password, name="reset_password"),
    path('signup',views.signup, name='signup'),
    path('save-cart-details/', views.savedetails_card, name='save_cart_details'),
    path('add_prodcut', views.add_product, name='add_prodcut'),
    path('category/<slug:slug>/', views.category_products, name='category_products'),
    path('product-details/<int:variant_id>/', views.product_details, name='product_details'),  # Pass variant ID
    path('submit-review/', views.submit_review, name='submit_review'),
    path('buy_process',views.buy_process, name="buy_process"),
    path('add_to_card',views.add_to_card,name="add_to_card"),
    path('cart-count/', views.cart_count, name='cart_count'),
    path('otp_format',views.otp, name="opt"),


] 
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
