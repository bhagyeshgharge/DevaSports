from app.models import *

def categories_context(request):
    return {
        'categories': Category.objects.all()
    }