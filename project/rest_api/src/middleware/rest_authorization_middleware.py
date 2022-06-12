""" Rest Authorization Middleware. """
import json
from django.core.cache import cache
from time import time
from http import HTTPStatus
from django.contrib.auth.models import User
from django.http.response import JsonResponse
from vendor.template import json_response
from vendor.errors import error_message
from django.conf import settings

class RestAuthorizationMiddleware(object):
    """ AuthorizationMiddleware: for handling authorization incoming user."""
    def __init__(self, get_response):
        """ init: initializing authorization middleware. """
        self.get_response = get_response

    def __call__(self, request):
        """ call: calling middleware for handling incoming user."""
        start_time = time()
        permissions = request.META.get('HTTP_X_PERMS', '')
        request.perms = permissions.split(',') if permissions else []

        response = self.get_response(request)

        env = settings.ENV
        elapsed_time = time() - start_time


        return response
