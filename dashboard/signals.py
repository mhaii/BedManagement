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


@receiver(pre_save, sender=Admit)
def handle_room_admits(sender, instance, **kwargs):
    current = Admit.objects.get(id=instance.id)

    if instance.status != current.status:
        if instance.status == 3:
            instance.room.status = 'AS'
            instance.room.save()
        elif instance.status == 4:
            instance.room = None

    if instance.room != current.room:
        if current.room is not None:
            current.room.status = 'AV'
            current.room.save()
        if instance.room is not None:
            instance.room.status = 'OC'
            instance.room.save()
