""" Rest CSRF Authentication. """
from rest_framework.authentication import SessionAuthentication

class RestCSRFAuthentication(SessionAuthentication):
    """ RestCSRFAuthentication: for overriding existing csrf authentication. """
    def enforce_csrf(self, request):
        """ enforce_csrf: overriding parent. """
        return
