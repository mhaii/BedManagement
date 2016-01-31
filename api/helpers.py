from django.db.models.query import QuerySet
from django.http import HttpResponse

from datetime import date, datetime
import json


class BetterEncoder(json.JSONEncoder):
    def default(self, o):
        if  isinstance(o, date) or isinstance(o, datetime):
            return o.isoformat()

        return json.JSONEncoder.default(self, o)


def JsonErrorResponse(error):
    if not isinstance(error, str):
        error = str(error)
    return json.dumps({'error': error})


def JsonResponse(jsonstring):
    if not isinstance(jsonstring, str):
        jsonstring = json.dumps(jsonstring)
    return HttpResponse(jsonstring, content_type='application/json')
