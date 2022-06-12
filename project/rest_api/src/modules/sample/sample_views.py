""" Sample Views."""
import json
from datetime import datetime
from collections import OrderedDict

from django.conf import settings

from rest_framework import status
from rest_framework.authentication import BasicAuthentication
from rest_framework.decorators import api_view, authentication_classes
from rest_framework.response import Response

from rest_api.src.authentication.rest_csrf_authentication import RestCSRFAuthentication
from rest_api.src.decorator.rest_decorator import rest_verify_permission

from vendor.template import json_response

@api_view(['GET'])
def ping(request):
    """ index: sample index page."""
    data = OrderedDict()
    data['status'] = 'OK'

    resp = json_response.render_response(data) 
    return Response(resp)
