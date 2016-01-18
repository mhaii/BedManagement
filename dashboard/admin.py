from django.contrib.admin import ModelAdmin
from django.contrib import admin
from .models import *


# Register your models here.
@admin.register(User)
class UserAdmin(ModelAdmin):
    list_display = ['name', 'role', 'ward']
    list_filter = ['role', 'ward']


@admin.register(Ward)
class WardAdmin(ModelAdmin):
    list_filter = ['name']


@admin.register(Room)
class RoomAdmin(ModelAdmin):
    list_display = ['room_number', 'ward', 'status', 'phone']
    list_filter = ['ward', 'status']


@admin.register(Admit)
class AdmitAdmin(ModelAdmin):
    list_display = ['patient', 'doctor', 'status', 'edd', 'symptom', 'admit_date']
    list_filter = ['doctor', 'status', 'edd']
    list_display_links = ['patient', 'doctor']


@admin.register(Patient)
class RoomAdmin(ModelAdmin):
    list_display = ['hn', 'first_name', 'last_name']


@admin.register(Doctor)
class DoctorAdmin(ModelAdmin):
    list_filter = ['name']


