from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.models import User
from django.shortcuts import render, redirect
from django.views.generic import View, RedirectView
from django.contrib.auth import authenticate, login, logout

from .forms import LoginForm


# Create your views here.
class LoginPage(View):
    def redirect_if_logged_in(self):
        pass

    def get(self, request):
        if request.user.is_authenticated():
            return redirect(request.GET.get('next', '/'))
        return render(request, 'authentication.html', context={'form': LoginForm()})

    def post(self, request):
        context = dict()
        user = authenticate(username=request.POST.get('username', ''), password=request.POST.get('password', ''))

        if user is not None:
            if user.is_active:
                login(request, user)
                return redirect(request.GET.get('next', '/'))
            else:
                context['error'] = 'This account is currently disabled, please contact IT department.'
        else:
            context['error'] = 'Password is incorrect.' if User.objects.filter(username=request.POST.get('username', '')).exists() else : 'Username not found.'

        context['form'] = LoginForm(request.POST)
        return render(request, 'authentication.html', context=context)


class LogoutPage(LoginRequiredMixin, View):
    def get(self, request):
        logout(request)
        return redirect('login')
