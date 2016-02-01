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
from django.core.urlresolvers import reverse_lazy
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import RedirectView, TemplateView

# this is for including signal handler, do not remove
from .signals import *


class TemplateViewRequiredLogin(LoginRequiredMixin, TemplateView):
    pass

urlpatterns = [
    url(r'^$', TemplateViewRequiredLogin.as_view(template_name='home.html'), name='landing'),
    url(r'^home/', RedirectView.as_view(url=reverse_lazy('landing')), name='home'),
    url(r'^status/$', TemplateViewRequiredLogin.as_view(template_name='status-all.html'), name='status'),
    url(r'^book-queue/', TemplateViewRequiredLogin.as_view(template_name='book-queue.html'), name='book_queue'),
    url(r'^edit-patient-info-filled/', TemplateViewRequiredLogin.as_view(template_name='edit-patient-info-filled.html'), name='edit_patient_info_filled'),
    url(r'^check-out/', TemplateViewRequiredLogin.as_view(template_name='check-out.html'), name='check_out'),
    url(r'^choose-bed/', TemplateViewRequiredLogin.as_view(template_name='choose-bed.html'), name='choose_bed'),
    url(r'^queues', TemplateViewRequiredLogin.as_view(template_name='queues.html'), name='queues'),
]