from django.conf.urls import url
from .views import *

urlpatterns = [
    url(r'^login/', LoginPage.as_view(), name='login'),
    url(r'^logout/', LogoutPage.as_view(), name='logout'),
    # TODO get rid of this when finished
    url(r'^create/(?P<username>\w+)/(?P<password>\w+)', CreateUser.as_view()),
]
