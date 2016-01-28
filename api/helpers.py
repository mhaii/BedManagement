from django.db.models.query import QuerySet
from django.http import HttpResponse

import json


def JsonErrorResponse(error):
    if not isinstance(error, str):
        error = str(error)
    return json.dumps({'error': error})


def JsonResponse(jsonstring):
    if not isinstance(jsonstring, str):
        jsonstring = json.dumps(jsonstring)
    return HttpResponse(jsonstring, content_type='application/json')
