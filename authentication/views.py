from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render, redirect
from django.views.generic import View
from django.contrib.auth import authenticate, login, logout

from . import helper
from .forms import LoginForm


# Create your views here.
class LoginPage(View):
    def get(self, request):
        context = helper.get_context(request)

        context['form'] = LoginForm()
        return render(request, 'authentication.html', context=context)

    def post(self, request):
        context = helper.get_context(request)
        user = authenticate(username=request.POST.get('username', ''), password=request.POST.get('password', ''))

        if user is not None:
            if user.is_active:
                login(request, user)
                return redirect('landing-page')
            else:
                # account disabled
                context['error'] = 'This account is currently disabled, please contact IT department.'
        else:
            context['error'] = 'Username or password is incorrect.'

        context['form'] = LoginForm(request.POST)
        return render(request, 'authentication.html', context=context)


class LogoutPage(LoginRequiredMixin, View):
    def get(self, request):
        logout(request)
        return redirect('login')
