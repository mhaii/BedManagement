from django.contrib.auth.decorators import login_required
from django.utils.translation import LANGUAGE_SESSION_KEY
from django.shortcuts import redirect

from rest_framework.decorators import detail_route, list_route
from rest_framework.permissions import IsAuthenticated
from rest_framework.viewsets import ModelViewSet
from rest_framework.response import Response

from datetime import date, timedelta
from .serializers import *

from dashboard.models import *

###############################################################################


@login_required
def switch_lang(request):
    lang = request.session.get(LANGUAGE_SESSION_KEY, 'en')
    request.session[LANGUAGE_SESSION_KEY] = 'en' if lang == 'th' else 'th'
    return redirect(request.META.get('HTTP_REFERER', '/'))

###############################################################################


class WardAPI(ModelViewSet):
    queryset = Ward.objects.all()
    serializer_class = WardSerializer
    permission_classes = [IsAuthenticated]

    @detail_route(serializer_class=RoomSerializer)
    def rooms(self, request, pk, *args, **kwargs):
        rooms = Ward.objects.get(pk=pk).rooms.all()

        page = self.paginate_queryset(rooms)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(rooms, many=True)
        return Response(serializer.data)

###############################################################################


class RoomAPI(ModelViewSet):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
    permission_classes = [IsAuthenticated]

###############################################################################


class PatientAPI(ModelViewSet):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
    permission_classes = [IsAuthenticated]

    @list_route()
    def current(self, request, *args, **kwargs):
        patients = Patient.objects.filter(admits__status__lt=3)

        page = self.paginate_queryset(patients)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(patients, many=True)
        return Response(serializer.data)

###############################################################################


class AdmitAPI(ModelViewSet):
    queryset = Admit.objects.all()
    serializer_class = AdmitSerializer
    permission_classes = [IsAuthenticated]

    @list_route()
    def queue(self, request, *args, **kwargs):
        days = request.GET.get('days', None)

        queues = Admit.objects.filter(status__lt=2)
        if days is None:
            queues = queues.filter(admit_date__gte=date.today())
        else:
            queues = queues.filter(admit_date__range=[date.today(), date.today() + timedelta(int(days))])

        page = self.paginate_queryset(queues)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queues, many=True)
        return Response(serializer.data)

    @list_route()
    def today(self, request, *args, **kwargs):
        admitted = Admit.objects.filter(admit_date__exact=date.today(), status__gte=2)

        page = self.paginate_queryset(admitted)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(admitted, many=True)
        return Response(serializer.data)

###############################################################################


class DoctorAPI(ModelViewSet):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer
    permission_classes = [IsAuthenticated]

###############################################################################