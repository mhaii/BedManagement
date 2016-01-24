from django.db.models import Model, ForeignKey, OneToOneField, ManyToManyField, CASCADE, \
    CharField, \
    PositiveSmallIntegerField, PositiveIntegerField, SmallIntegerField, IntegerField, \
    DateField, DateTimeField

from django.utils.translation import ugettext_lazy as _
from django.utils import timezone

from datetime import timedelta


class WardType(Model):
    name = CharField(_('Ward Type'), max_length=30, default='Ward')
    abbreviation = CharField(_('Abbreviated Ward Type'), max_length=6)

    class Meta:
        verbose_name = _('Ward Type')
        verbose_name_plural = _('Ward Types')

    def __str__(self):
        return str(self.name)

    def as_dict(self):
        return dict(name=self.name, abbreviation=self.abbreviation)


# Create your models here.
class Ward(Model):
    enum_type = [
        (1, _('Single')),
        (2, _('Double')),
    ]

    name = CharField(_('Ward Name'), max_length=15, default='Ward')
    type = ManyToManyField(WardType, verbose_name=_('Ward Type'), related_name='wards')
    price = IntegerField(_('Default price for room'), default=0)
    phone = CharField(_('Phone no.'), max_length=12)
    number = PositiveSmallIntegerField(_('Bed')+':', default=1, choices=enum_type)

    class Meta:
        verbose_name = _('Ward')
        verbose_name_plural = _('Wards')

    def __str__(self):
        return str(self.name)

    def as_dict(self):
        return dict(name=self.name, type=self.type, price=self.price, phone=self.phone, number=self.number)


class Room(Model):
    enum_status = [
        ('DIS', _('Disabled')),
        ('RES', _('Reserved')),
        ('OCC', _('Occupied')),
        ('AVS', _('Available Soon')),
        ('AVN', _('Available')),
    ]

    room_number = CharField(_('Room no.'), max_length=7)
    status = CharField(_('Room status'), max_length=3, choices=enum_status, default='AVN')
    ward = ForeignKey(Ward, verbose_name=_('Ward'),  related_name='rooms')
    price = IntegerField(_('Room price'), default=0)

    class Meta:
        verbose_name = _('Room')
        verbose_name_plural = _('Rooms')

    def __str__(self):
        return '[{0}] {1}'.format(*map(str, [self.ward, self.room_number]))

    def as_dict(self):
        return dict(room_number=self.room_number, status=self.status, ward=self.status, price=self.price)


class Patient(Model):
    hn = CharField(_("Patient's HN number"), max_length=14, unique=True, primary_key=True)
    first_name = CharField(_('First name'), max_length=20)
    last_name = CharField(_('Last name'), max_length=20)

    class Meta:
        verbose_name = _('Patient')
        verbose_name_plural = _('Patients')

    def __str__(self):
        return '[{0}] {1} {2}'.format(*map(str, [self.hn, self.first_name, self.last_name]))

    def as_dict(self):
        return dict(hn=self.hn, first_name=self.first_name, last_name=self.last_name)


class Doctor(Model):
    name = CharField(_("Doctor's name"), max_length=50)

    class Meta:
        verbose_name = _('Doctor')
        verbose_name_plural = _('Doctors')

    def __str__(self):
        return str(self.name)

    def as_dict(self):
        return dict(name=self.name)


class Admit(Model):
    def yesterday():
        return timezone.now() - timedelta(1)

    enum_status = [
        ('DIS', _('Discharged')),
        ('PRE', _('Pre-discharged')),
        ('CUR', _('Currently admit')),
        ('QUE', _('In Queue')),
    ]

    patient = ForeignKey(Patient, verbose_name=_('Patient'), related_name='admits')
    doctor = ForeignKey(Doctor, verbose_name=_('Primary Doctor'), related_name='patients')
    status = CharField(_('Patient Status'), max_length=3, choices=enum_status, default='QUE')
    edd = DateField(_('Estimated date to be discharged'), default=yesterday)
    symptom = CharField(_('Symptom'), max_length=30)
    admit_date = DateTimeField(_('Admitted Date'), auto_now_add=True)

    class Meta:
        verbose_name = _('Admit')
        verbose_name_plural = _('Admits')

    def __str__(self):
        return str(self.patient)

    def as_dict(self):
        return dict(
            patient=self.patient, doctor=self.doctor, status=self.status,
            edd=self.edd, symptom=self.symptom, admit_date=self.admit_date
        )
