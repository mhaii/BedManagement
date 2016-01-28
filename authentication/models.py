from django.db.models import Model, ForeignKey, OneToOneField, CASCADE

from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User, Group
from dashboard.models import Ward


# Create your models here.
class Staff(Model):
    def get_default_group(self=None):
        # get_or_create returns tuple (object, created)
        return Group.objects.get_or_create(name='Nobody')[0]

    user = OneToOneField(User, verbose_name=_('User'), related_name='staff', unique=True, on_delete=CASCADE)
    role = ForeignKey(Group, verbose_name=_('Role'), related_name='+', default=get_default_group)
    ward = ForeignKey(Ward, verbose_name=_('Ward'), related_name='staffs', null=True, blank=True)

    def __str__(self):
            return '[{0}] {1}'.format(*map(str, [self.role, self.name]))

# placebo for translating role-group name
_('Nobody')
_('Cashier')
_('Nurse Assistance')
_('Nurse')
_('Admission')
_('Administrator')
