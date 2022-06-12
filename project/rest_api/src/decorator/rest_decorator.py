""" Rest Decorator. """
from time import time
from http import HTTPStatus
from django.conf import settings
from rest_framework.response import Response
from vendor.template import json_response 
from vendor.errors import error_message

def rest_verify_permission(permissions):
    """ rest_verify_allowed_permission: for verifying allowed permission. """
    def decorator(function):
        """ decorator: for decorator factory. """
        def wrap(request, *args, **kwargs):
            """ wrap: for wrapping function. """
            start_time = time()
            # allowed_permissions = settings.PERMISSIONS['allowed_permissions'].split("\n")
            if permissions in request.perms:
                return function(request, *args, **kwargs)
            resp = json_response.render_error_response(error_message.ERR_FORBIDDEN, start_time)
            return Response(resp, status=HTTPStatus.FORBIDDEN.value)
        return wrap
    return decorator