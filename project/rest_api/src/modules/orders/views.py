import logging
import time

from rest_framework import status
from rest_framework.authentication import BasicAuthentication
from rest_framework.decorators import api_view, authentication_classes
from rest_api.src.authentication.rest_csrf_authentication import RestCSRFAuthentication
from rest_api.src.decorator.rest_decorator import rest_verify_permission
from rest_framework.response import Response

from vendor.errors import error_message
from vendor.helper import helper
from vendor.template import json_response
from .handler import OrdersHandler

logger = logging.getLogger(__name__)


@api_view(['GET'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def get_basket(request):
    """ to get list merchants."""

    start_time = time.time()

    handler = OrdersHandler(start_time)
    response, status_code = handler.get_basket()
    
    return Response(response, status=status_code)


@api_view(['POST'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def update_basket(request):
    """ to update basket."""

    start_time = time.time()

    handler = OrdersHandler(start_time)
    request_body = helper.json_to_dict(request.body)
    response, status_code = handler.update_basket(request_body)
    
    return Response(response, status=status_code)

@api_view(['POST'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def update_basket(request):
    """ to update basket."""

    start_time = time.time()

    handler = OrdersHandler(start_time)
    request_body = helper.json_to_dict(request.body)
    response, status_code = handler.update_basket(request_body)
    
    return Response(response, status=status_code)


@api_view(['POST'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def pay(request):
    """ to pay order."""

    start_time = time.time()

    handler = OrdersHandler(start_time)
    request_body = helper.json_to_dict(request.body)
    response, status_code = handler.pay(request_body)
    
    return Response(response, status=status_code)

@api_view(['GET'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def get_list_order(request):
    """ to get list order."""

    start_time = time.time()

    handler = OrdersHandler(start_time)
    response, status_code = handler.get_list_order()
    
    return Response(response, status=status_code)

@api_view(['GET'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def get_detail_order(request, order_id):
    """ to get detail order."""

    start_time = time.time()

    handler = OrdersHandler(start_time)
    request_body = helper.json_to_dict(request.body)
    response, status_code = handler.get_order_detail(order_id)
    
    return Response(response, status=status_code)

@api_view(['GET'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def get_history_order(request):
    """ to get list order."""

    start_time = time.time()

    handler = OrdersHandler(start_time)
    response, status_code = handler.get_history_order()
    
    return Response(response, status=status_code)
