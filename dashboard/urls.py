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