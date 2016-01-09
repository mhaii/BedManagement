from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render

# Create your views here.
from django.views.generic import View


class Landing(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'basefile.html')


class Status(View):
    def get(self, request):
        return render(request, 'status-all.html')


class CheckIn(View):
    def get(self, request):
        return render(request, 'check-in.html')