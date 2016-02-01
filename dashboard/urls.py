from django.conf.urls import url
from .views import *

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