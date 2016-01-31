from django.contrib import admin
from django.contrib.admin import ModelAdmin

from .models import *

admin.site.unregister(User)


# Register your models here.
class UserInline(admin.StackedInline):
    model = Staff
    # radio_fields = {'role': admin.HORIZONTAL}
    # list_filter = ['role']
    can_delete = False


@admin.register(User)
class UserAdmin(ModelAdmin):
    inlines = [UserInline]


