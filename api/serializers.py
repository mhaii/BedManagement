from dashboard.models import *
from rest_framework.serializers import \
    ModelSerializer, \
    SerializerMethodField, StringRelatedField, PrimaryKeyRelatedField, ChoiceField

###############################################################################


class WardSerializer(ModelSerializer):
    type = StringRelatedField(many=True)

    class Meta:
        model = Ward
        fields = '__all__'

###############################################################################


class RoomSerializer(ModelSerializer):
    status = ChoiceField(choices=Room.enum_status, write_only=True)
    status_r = SerializerMethodField(read_only=False)

    @staticmethod
    def get_status_r(o):
        return {'key': o.status, 'value': o.get_status_display()}

    class Meta:
        model = Room
        fields = '__all__'

###############################################################################


class WardRoomSerializer(WardSerializer):
    rooms = RoomSerializer(many=True)

###############################################################################


class PatientSerializer(ModelSerializer):
    class Meta:
        model = Patient
        fields = '__all__'

###############################################################################


class AdmitSerializer(ModelSerializer):
    doctor = PrimaryKeyRelatedField(queryset=Doctor.objects.all(), write_only=True)
    doctor_r = SerializerMethodField()
    status = ChoiceField(choices=Admit.enum_status, write_only=True)
    status_r = SerializerMethodField()

    @staticmethod
    def get_doctor_r(o):
        return {'key': o.doctor.id, 'value': o.doctor.name}

    @staticmethod
    def get_status_r(o):
        return {'key': o.status, 'value': o.get_status_display()}

    class Meta:
        model = Admit
        fields = '__all__'

###############################################################################


class DoctorSerializer(ModelSerializer):
    class Meta:
        model = Doctor
        fields = '__all__'

###############################################################################


class AdmitDetailedSerializer(AdmitSerializer):
    class Meta:
        model = Admit
        depth = 1

###############################################################################
