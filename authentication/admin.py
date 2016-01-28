from django.contrib import admin
from django.contrib.admin import ModelAdmin

from .models import *


# Register your models here.
class UserInline(admin.StackedInline):
    model = Staff
    # radio_fields = {'role': admin.HORIZONTAL}
    # list_filter = ['role']
    can_delete = False


class UserAdmin(ModelAdmin):
    inlines = [UserInline]


# Re-register UserAdmin
admin.site.unregister(User)
admin.site.register(User, UserAdmin)
