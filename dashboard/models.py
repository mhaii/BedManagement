from django.db.models import Model, CharField, DateTimeField, PositiveIntegerField, PositiveSmallIntegerField, SmallIntegerField
from django.db.models import ForeignKey


# Create your models here.
class Ward(Model):
    name = CharField('Name of the Ward', max_length=30, default='Olympus')

    def __str__(self):
        return str(self.name)


class Patient(Model):
    hn = PositiveIntegerField(unique=True, primary_key=True)
    first_name = CharField(max_length=20)
    last_name = CharField(max_length=20)

    def __str__(self):
        return '[{0}] {1} {2}'.format(*map(str, [self.hn, self.first_name, self.last_name]))


class Doctor(Model):
    name = CharField(max_length=50)

    def __str__(self):
        return str(self.name)


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

    def __str__(self):
        return '[{0}] {1}'.format(*map(str, [self.role, self.name]))


class Room(Model):
    enum_status = [
        ('DIS', 'Disabled'),
        ('RES', 'Reserved'),
        ('OCC', 'Occupied'),
        ('AVS', 'Available Soon'),
        ('AVI', 'Available'),
    ]

    room_number = CharField(max_length=7)
    status = CharField(max_length=3, choices=enum_status, default='DIS')
    phone = CharField(max_length=10)
    ward = ForeignKey(Ward)
    # not really sure about this
    type = CharField(max_length=20)

    def __str__(self):
        return '[{0}] {1} {2}'.format(*map(str, [self.ward, self.room_number, self.phone]))


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
    edd = PositiveSmallIntegerField('Estimated day(s) to discharged', default=-1)
    symptom = CharField(max_length=30)
    admit_date = DateTimeField(auto_now_add=True)

    def __str__(self):
        return str(self.patient)
