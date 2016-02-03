from rest_framework.serializers import \
    ModelSerializer, Serializer, \
    SerializerMethodField, StringRelatedField
from dashboard.models import *

###############################################################################


class WardSerializer(ModelSerializer):
    type = StringRelatedField(many=True)

    def create(self, validated_data):
        return Ward.objects.create(**validated_data)

    def update(self, instance, validated_data):
        pass

    class Meta:
        model = Ward
        fields = '__all__'

###############################################################################


class RoomSerializer(ModelSerializer):
    status = SerializerMethodField()

    @staticmethod
    def get_status(o):
        return {'key': o.status, 'value': o.get_status_display()}

    def create(self, validated_data):
        return Room.objects.create(**validated_data)

    def update(self, instance, validated_data):
        pass

    class Meta:
        model = Room
        fields = '__all__'

###############################################################################


class PatientSerializer(ModelSerializer):

    def create(self, validated_data):
        return Patient.objects.create(**validated_data)

    def update(self, instance, validated_data):
        pass

    class Meta:
        model = Patient
        fields = '__all__'
        depth = 1

###############################################################################


class AdmitSerializer(ModelSerializer):
    doctor = StringRelatedField()
    status = SerializerMethodField()

    @staticmethod
    def get_status(o):
        return {'key': o.status, 'value': o.get_status_display()}

    def create(self, validated_data):
        return Admit.objects.create(**validated_data)

    def update(self, instance, validated_data):
        pass

    class Meta:
        model = Admit
        fields = '__all__'
        depth = 1

###############################################################################


class DoctorSerializer(ModelSerializer):
    def create(self, validated_data):
        pass

    def update(self, instance, validated_data):
        pass

    class Meta:
        model = Doctor
        fields = '__all__'

###############################################################################
