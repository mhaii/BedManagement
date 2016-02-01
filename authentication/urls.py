from django.conf.urls import url
from .views import *

urlpatterns = [
    url(r'^login/', LoginPage.as_view(), name='login'),
    url(r'^logout/', LogoutPage.as_view(), name='logout'),
]
