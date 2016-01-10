from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render, redirect

# Create your views here.
from django.views.generic import View


class Landing(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'home.html')


class Status(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'status-all.html')


class CheckIn(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'check-in.html')


class Home(LoginRequiredMixin, View):
    def get(self, request):
        return redirect('landing')
