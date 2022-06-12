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
from .handler import MerchantHandler

logger = logging.getLogger(__name__)


@api_view(['POST'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def get_list_merchants(request):
    """ to get list merchants."""

    start_time = time.time()

    handler = MerchantHandler(start_time)
    request_body = helper.json_to_dict(request.body) 
    response, status_code = handler.list_merchant(request_body)
    
    return Response(response, status=status_code)
    

@api_view(['POST'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def get_list_meals(request):
    """ to get list meals."""

    start_time = time.time()

    handler = MerchantHandler(start_time)
    request_body = helper.json_to_dict(request.body) 
    response, status_code = handler.list_meals(request_body)

    return Response(response, status=status_code)

@api_view(['GET'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def detail_meals(request, meals_id):
    """ to get detail meals."""

    start_time = time.time()

    handler = MerchantHandler(start_time)
    response, status_code = handler.get_meals_detail(meals_id)
    
    return Response(response, status=status_code)

@api_view(['GET'])
@authentication_classes((RestCSRFAuthentication, BasicAuthentication))
@rest_verify_permission('can_get_bento')
def merchant_detail(request, merchant_id):
    """ to get merchant detail."""

    start_time = time.time()

    data = helper.json_to_dict(request.body) 

    handler = MerchantHandler(start_time)
    response, status_code = handler.merchant_detail(merchant_id)

    return Response(response, status=status_code)