from django.contrib.admin import ModelAdmin
from django.contrib import admin
from .models import *


@admin.register(WardType)
class WardTypeAdmin(ModelAdmin):
    list_display = ['name', 'abbreviation']


@admin.register(Ward)
class WardAdmin(ModelAdmin):
    list_display = ['name', 'number', 'phone']
    list_filter = ['number']
    radio_fields = {'number': admin.HORIZONTAL}


@admin.register(Room)
class RoomAdmin(ModelAdmin):
    list_display = ['room_number', 'ward', 'status']
    list_filter = ['ward', 'status']
    radio_fields = {'status': admin.HORIZONTAL}


@admin.register(Admit)
class AdmitAdmin(ModelAdmin):
    list_display = ['patient', 'symptom', 'doctor', 'edd', 'admit_date']
    list_display_links = ['patient', 'doctor']
    list_filter = ['status', 'edd']
    radio_fields = {'status': admin.HORIZONTAL}


@admin.register(Patient)
class PatientAdmin(ModelAdmin):
    list_display = ['hn', 'first_name', 'last_name']


@admin.register(Doctor)
class DoctorAdmin(ModelAdmin):
    list_display = ['name']
