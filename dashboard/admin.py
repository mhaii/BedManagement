from django.contrib.admin import ModelAdmin
from django.contrib import admin
from django.db.models import Count
from .models import *

from django.utils.translation import ugettext_lazy as _

# non-overriding method has 2 arguments (Model's Admin, instance of Admin)
# `get_queryset` fetches meta for counting children (rooms)


@admin.register(Admit)
class AdmitAdmin(ModelAdmin):
    list_display = ['patient', 'symptom', 'doctor', 'admit_date', 'edd']
    list_display_links = ['patient', 'doctor']
    list_filter = ['status', 'edd']
    radio_fields = {'status': admin.HORIZONTAL}


@admin.register(Doctor)
class DoctorAdmin(ModelAdmin):
    list_display = ['name']


@admin.register(Patient)
class PatientAdmin(ModelAdmin):
    list_display = ['hn', 'first_name', 'last_name']


@admin.register(Room)
class RoomAdmin(ModelAdmin):
    list_display = ['number', 'price', 'ward', 'status']
    list_filter = ['ward', 'status']
    radio_fields = {'status': admin.HORIZONTAL}


@admin.register(Ward)
class WardAdmin(ModelAdmin):
    list_display = ['name', 'remark', 'bed_type', 'phone', '_room_count']
    list_filter = ['bed_type']
    radio_fields = {'bed_type': admin.HORIZONTAL}

    def get_queryset(self, request):
        return Ward.objects.annotate(room_count=Count('rooms'))

    def _room_count(self, instance):
        return instance.room_count
    _room_count.__name__ = str(_('Room Count'))


@admin.register(WardType)
class WardTypeAdmin(ModelAdmin):
    list_display = ['name', 'abbreviation']


