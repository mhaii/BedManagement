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
from django.conf.urls import url

from .views import BookQueue, CheckOut, ChooseBed, Home, Landing, Status, EditPatientInfo, Queues

urlpatterns = [
    url(r'^home/', Home.as_view(), name='home'),
    url(r'^status/$', Status.as_view(), name='status'),
    url(r'^book-queue/', BookQueue.as_view(), name='book_queue'),
    url(r'^edit-patient-info-filled/', EditPatientInfo.as_view(), name='edit_patient_info_filled'),
    url(r'^check-out/', CheckOut.as_view(), name='check_out'),
    url(r'^choose-bed/', ChooseBed.as_view(), name='choose_bed'),
    url(r'^queues', Queues.as_view(), name='queues'),
    url(r'^$', Landing.as_view(), name='landing'),
]