from django.template import Library

register = Library()


@register.filter(name='times')
def times(until, start=0):
    return range(start, until)


@register.filter(name='subtract')
def subtract(minuend, subtrahend):
    return minuend - subtrahend
