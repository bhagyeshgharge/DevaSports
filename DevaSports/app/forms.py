# app/forms.py

from django import forms

class EmailForm(forms.Form):
    email = forms.EmailField(label="Email", max_length=255)

class OTPForm(forms.Form):
    otp = forms.CharField(label="Enter OTP", max_length=6, min_length=6)
