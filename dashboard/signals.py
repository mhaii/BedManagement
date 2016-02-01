from django.db.models.signals import pre_save, post_save
from django.dispatch import receiver

from .models import Admit, Room


@receiver(post_save, sender=Room)
def handle_room_save(sender, instance, created, **kwargs):
    print(instance.price, not instance.price)
    if not instance.price:
        instance.price = instance.ward.price
        instance.save()
    else:
        print('room %s is updated' % instance)
