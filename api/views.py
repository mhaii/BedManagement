from django.shortcuts import redirect
from django.utils.translation import LANGUAGE_SESSION_KEY


# Create your views here.
def switch_lang(request):
    lang = request.session.get(LANGUAGE_SESSION_KEY, 'en')
    request.session[LANGUAGE_SESSION_KEY] = 'en' if lang == 'th' else 'th'
    return redirect(request.META.get('HTTP_REFERER', '/'))
