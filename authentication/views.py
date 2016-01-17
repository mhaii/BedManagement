from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.models import User
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.views.generic import View
from django.contrib.auth import authenticate, login, logout
from django.utils.translation import ugettext_lazy as _

from .forms import LoginForm


# Create your views here.
class LoginPage(View):
    def get(self, request):
        if request.user.is_authenticated():
            return redirect(request.GET.get('next', '/'))
        return render(request, 'authentication.html')

    def post(self, request):
        context = dict()
        user = authenticate(username=request.POST.get('username', ''), password=request.POST.get('password', ''))

        if user is not None:
            if user.is_active:
                login(request, user)
                return redirect(request.GET.get('next', '/'))
            else:
                context['error'] = _('This account is currently disabled, please contact IT department.')
        else:
            context['error'] = _('Password is incorrect.') if User.objects.filter(username=request.POST.get('username', '')).exists() else _('Username not found.')

        context['form'] = LoginForm(request.POST)
        return render(request, 'authentication.html', context=context)


class LogoutPage(LoginRequiredMixin, View):
    def get(self, request):
        logout(request)
        return redirect('login')


# TODO get rid of this when finished
class CreateUser(View):
    def get(self, request, username, password):
        print(username)
        print(password)
        User.objects.create_user(username=username, password=password)
        return HttpResponse('ok', status=201)
