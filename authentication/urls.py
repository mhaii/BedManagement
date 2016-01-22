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
from .views import *

# this is for including signal handler, do not remove
from .signals import *

urlpatterns = [
    url(r'^login/', LoginPage.as_view(), name='login'),
    url(r'^logout/', LogoutPage.as_view(), name='logout'),
    # TODO get rid of this when finished
    url(r'^create/(?P<username>\w+)/(?P<password>\w+)', CreateUser.as_view()),
]
