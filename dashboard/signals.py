# include into django flow via `import` through `url.py`
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

from .models import Admit, Room


@receiver(post_save, sender=Room)
def handle_room_save(sender, instance, created, **kwargs):
    print('room %s is updated' % instance)