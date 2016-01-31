from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render, redirect

from django.views.generic import View
from .models import *


class Landing(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'home.html')


class Status(LoginRequiredMixin, View):
    def get(self, request):
        context = dict()
        wards = Ward.objects.all()
        context['wards'] = wards
        context['max_room'] = max([ward.rooms.count() for ward in wards])
        return render(request, 'status-all.html', context=context)


class BookQueue(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'book-queue.html')


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
        return render(request, 'edit-patient-info-filled.html')


class Queues(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'queues.html')
