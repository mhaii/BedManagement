from django.db.models import Model, CharField, DateTimeField, PositiveIntegerField, PositiveSmallIntegerField, SmallIntegerField
from django.db.models import ForeignKey


# Create your models here.
class Ward(Model):
    name = CharField('Name of the Ward', max_length=30, default='Olympus')


class Patient(Model):
    hn = PositiveIntegerField(unique=True, primary_key=True, editable=False)
    first_name = CharField(max_length=20)
    last_name = CharField(max_length=20)


class Doctor(Model):
    name = CharField(max_length=50)


class User(Model):
    enum_role = [
        (-2, 'Cashier'),
        (-1, 'Nurse Assistance'),
        (0, 'Nobody'),
        (1, 'Nurse'),
        (2, 'Admission'),
        (3, 'Administrator'),
    ]

    name = CharField('Name of the User', max_length=50, default='Saitama-san')
    role = SmallIntegerField('Role of the User', choices=enum_role, default=0)
    ward = ForeignKey(Ward, blank=True)


class Room(Model):
    enum_status = [
        ('DIS', 'Disabled'),
        ('RES', 'Reserved'),
        ('OCC', 'Occupied'),
        ('AVS', 'Available Soon'),
        ('AVI', 'Available'),
    ]

    room_number = CharField(max_length=7, editable=False)
    status = CharField(max_length=3, choices=enum_status, default='DIS')
    phone = CharField(max_length=10)
    ward = ForeignKey(Ward)
    # not really sure about this
    type = CharField(max_length=20)


class Admit(Model):
    enum_status = [
        ('DIS', 'Discharged'),
        ('PRE', 'Pre-discharged'),
        ('CUR', 'Currently admit'),
        ('QUE', 'In Queue'),
    ]

    patient = ForeignKey(Patient)
    doctor = ForeignKey(Doctor)
    status = CharField(max_length=3, choices=enum_status, default='QUE')
    edd = PositiveSmallIntegerField('Estimated duration until discharged', default=-1)
    symptom = CharField(max_length=30)
    admit_date = DateTimeField(auto_now_add=True)

