"""bedManagement URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import include, url

from .views import *

# Convention-based REST router lol
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'wards', WardAPI)
router.register(r'rooms', RoomAPI)
router.register(r'patients', PatientAPI)
router.register(r'admits', AdmitAPI)
router.register(r'doctors', DoctorAPI)

urlpatterns = [
    url(r'^switch-lang/', switch_lang, name='switch-lang'),
    url(r'', include(router.urls))

]