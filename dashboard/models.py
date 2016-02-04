from django.db.models import Model, ForeignKey, OneToOneField, ManyToManyField, CASCADE, \
    CharField, PositiveSmallIntegerField, IntegerField, DateField, DateTimeField

from django.utils.translation import ugettext_lazy as _
from django.utils import timezone


class WardType(Model):
    name = CharField(_('Ward Type'), max_length=30, default='Ward')
    abbreviation = CharField(_('Abbreviated Ward Type'), max_length=6)

    class Meta:
        verbose_name = _('Ward Type')
        verbose_name_plural = _('Ward Types')

    def __str__(self):
        return str(self.name)

    def as_dict(self):
        return dict(id=self.id, name=self.name, abbreviation=self.abbreviation)


class Ward(Model):
    enum_type = [
        (1, _('Single')),
        (2, _('Double')),
        (3, _('Mixed')),
    ]

    name = CharField(_('Ward Name'), max_length=15)
    remark = CharField(_('Ward Detail'), max_length=15, blank=True)
    type = ManyToManyField(WardType, verbose_name=_('Ward Type'), related_name='wards', blank=True)
    price = IntegerField(_('Default price for room'), default=0)
    phone = CharField(_('Phone no.'), max_length=12)
    bed_type = PositiveSmallIntegerField(_('Bed')+':', default=1, choices=enum_type)

    class Meta:
        verbose_name = _('Ward')
        verbose_name_plural = _('Wards')

    def __str__(self):
        return str('{0} {1} {2} {3} ({4})'.format(_(self.name), ' '.join([str(_(word)) for word in str(self.remark).split()]),
                                                  _('Tel.'), self.phone, self.price))


(_('East'),  _('West'),  _('Male'),  _('Female'))


class Room(Model):
    enum_status = [
        ('DI', _('Disabled')),
        ('RE', _('Reserved')),
        ('OC', _('Occupied')),
        ('AS', _('Available Soon')),
        ('AV', _('Available')),
    ]

    number = CharField(_('Room no.'), max_length=7)
    status = CharField(_('Room status'), max_length=2, choices=enum_status, default='AV')
    ward = ForeignKey(Ward, verbose_name=_('Ward'), related_name='rooms', on_delete=CASCADE)
    price = IntegerField(_('Room price'), default=0)

    class Meta:
        verbose_name = _('Room')
        verbose_name_plural = _('Rooms')

    def __str__(self):
        return '[{0}] {1}'.format(*map(str, [self.ward, self.number]))


class Patient(Model):
    hn = CharField(_("Patient's HN number"), max_length=14, unique=True, primary_key=True)
    first_name = CharField(_('First name'), max_length=20)
    last_name = CharField(_('Last name'), max_length=20)
    phone = CharField(_('Phone no.'), max_length=15, blank=True, default='')

    class Meta:
        verbose_name = _('Patient')
        verbose_name_plural = _('Patients')

    def __str__(self):
        return '[{0}] {1} {2}'.format(*map(str, [self.hn, self.first_name, self.last_name]))


class Doctor(Model):
    name = CharField(_("Doctor's name"), max_length=50)

    class Meta:
        verbose_name = _('Doctor')
        verbose_name_plural = _('Doctors')

    def __str__(self):
        return str(self.name)


class Admit(Model):
    enum_status = [
        (0, _('Pending')),
        (1, _('Confirmed')),
        (2, _('Currently admit')),
        (3, _('Pre-discharged')),
        (4, _('Discharged')),
    ]

    patient = ForeignKey(Patient, verbose_name=_('Patient'), related_name='admits', on_delete=CASCADE)
    doctor = ForeignKey(Doctor, verbose_name=_('Primary Doctor'), related_name='patients')
    status = PositiveSmallIntegerField(_('Patient Status'), choices=enum_status, default=0)
    room = OneToOneField(Room, verbose_name=_('Room'), related_name='patient', blank=True, null=True)
    admit_date = DateTimeField(_('Admitted Date'), default=timezone.now)
    edd = DateField(_('Estimated date to be discharged'), default=None, blank=True, null=True)
    symptom = CharField(_('Symptom'), max_length=30)

    class Meta:
        verbose_name = _('Admit')
        verbose_name_plural = _('Admits')

    def __str__(self):
        return str(self.patient)


