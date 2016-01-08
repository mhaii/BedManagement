from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.
from django.views.generic import View

from authentication import helper


# @helper.require_login_class_html
class landing(View):
    def get(self, request):
        return render(request, 'basefile.html')
