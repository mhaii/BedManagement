from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.
from django.views.generic import View


class landing(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'basefile.html')
