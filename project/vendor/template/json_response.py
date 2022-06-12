""" Template Response. """
from time import time
from collections import OrderedDict
from http import HTTPStatus

def render_response(result, process_time=time(), request_body={}, total_records=0):
    """ render_response: for rendering response. """
    response = OrderedDict()
    response['meta'] = OrderedDict()
    response['meta']['app'] = 'GrabBento'
    response['meta']['process_time'] = time()-process_time
    response['meta']['args'] = request_body
    response['meta']['total_records'] = total_records
    response['data'] = result
    
    return response

def render_error_response(error_message, process_time=time(), request_body={}):
    """ render_error_response: for rendering error response."""
    response = OrderedDict()
    response['meta'] = OrderedDict()
    response['meta']['app'] = 'GrabBento'
    response['meta']['process_time'] = time()-process_time
    response['meta']['args'] = request_body
    #response['meta']['total_records'] = total_records
    response['error'] = OrderedDict()
    response['error']['is_error'] = True
    response['error']['error_message'] = error_message

    return response

#  new success and error response convention
def render_api_success_response(result, process_time=time(), request_body={}, total_records=0):
    """ render_response: for rendering response. """
    response = OrderedDict()
    response['meta'] = OrderedDict()
    response['meta']['app'] = 'GrabBento'
    response['meta']['process_time'] = time()-process_time
    response['meta']['args'] = request_body
    response['meta']['total_records'] = total_records
    response['data'] = result
    return response

def render_api_error_response(error_message="", error_list=[], process_time=time(), request_body={}, status=400):

    """ render_error_response: for rendering error response."""
    response = OrderedDict()
    response['meta'] = OrderedDict()
    response['meta']['app'] = 'GrabBento'
    response['meta']['process_time'] = time()-process_time
    response['meta']['args'] = request_body
    response['error'] = OrderedDict()
    response['error']['status'] = status
    response['error']['message'] = error_message
    response['error']['detail'] = error_list

    return response

#  new success and error response convention
def render_api_dashboard_success_response(result, process_time=time(), request_body={}, total_records=0):
    """ render_response: for rendering response. """
    response = OrderedDict()
    response['meta'] = OrderedDict()
    response['meta']['app'] = 'GrabBento'
    response['meta']['process_time'] = time()-process_time
    response['meta']['args'] = request_body
    response['meta']['total_records'] = total_records
    response['data'] = result
    return response
