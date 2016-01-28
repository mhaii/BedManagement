from django.contrib.auth.decorators import login_required
from django.utils.translation import LANGUAGE_SESSION_KEY
from django.shortcuts import redirect

from dashboard.models import *
from .helpers import *

# Create your views here.


@login_required
def switch_lang(request):
    lang = request.session.get(LANGUAGE_SESSION_KEY, 'en')
    request.session[LANGUAGE_SESSION_KEY] = 'en' if lang == 'th' else 'th'
    return redirect(request.META.get('HTTP_REFERER', '/'))


@login_required
def get_ward_all(request):
    query = list(Ward.objects.defer('id').values())
    for each in query:
        each['rooms'] = list(Room.objects.filter(ward=each['id']).values())
    return JsonResponse(query)


@login_required
def get_ward(request, id):
    try:
        query = Ward.objects.get(id=id).values()
    except Ward.DoesNotExist:
        return JsonErrorResponse('Specified ward does not exist.')
    return JsonResponse(query)
