import random
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.conf import settings
from email.utils import formataddr

def generate_otp():
    return str(random.randint(100000, 999999))

def send_otp_email(email, otp, purpose):
    if purpose == "signup":
        subject = "Verify Your Email - Signup OTP"
        message = "Use the OTP below to complete your registration."
    elif purpose == "reset":
        subject = "Reset Your Password - OTP Verification"
        message = "Use the OTP below to reset your password."
    else:
        subject = "OTP Verification"
        message = "Use the OTP below for verification."

    context = {
        'otp': otp,
        'title': subject,
        'message': message,
    }

    text_content = f"{subject}\n\n{message}\n\nOTP: {otp}"
    html_content = render_to_string("otp.html", context)

    email_message = EmailMultiAlternatives(
        subject,
        text_content,
           formataddr(("Deva Sports", settings.EMAIL_HOST_USER)),  # ✅ show name instead of "me"
        [email],
    )
    email_message.attach_alternative(html_content, "text/html")
    email_message.send()
