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


class BookQueue(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'bookQueues.html')


class Home(LoginRequiredMixin, View):
    def get(self, request):
        return redirect('landing')


class CheckOut(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'check-out.html')


class ChooseBed(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'choose-bed.html')


class EditPatientInfo(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'edit_patient_info-filled.html')


class Queues(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'queues.html')
