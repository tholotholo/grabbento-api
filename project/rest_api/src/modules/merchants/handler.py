import logging
from datetime import datetime

from django.conf import settings
from django.db.models import Sum
from rest_framework import status

from rest_admin.src.modules.merchants.models import Merchants
from rest_admin.src.modules.meals.models import Meals

from vendor.errors import error_message
from vendor.helper import helper
from vendor.template import json_response

import random

logger = logging.getLogger(__name__)

class MerchantHandler():

    def __init__(self, start_time):
        self.start_time = start_time
        

    def list_merchant(self, request_body):
        project_filter = {}

        if "category" in request_body:
            project_filter["category"] = request_body["category"]

        if "meals_time" in request_body:
            project_filter["meals_time__icontains"] = request_body["meals_time"]

        merchant_list = Merchants.objects.filter(**project_filter).exclude(category="Mystery").order_by('-id')

        merchant = []
        for data in merchant_list:
            merchant.append(self.get_merchant_info(data))

        resp = json_response.render_api_success_response(merchant, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK

    def list_meals(self, request_body):
        project_filter = {}
        if "category" in request_body:
            project_filter["category"] = request_body["category"]

        if "meals_time" in request_body:
            project_filter["meals_time__icontains"] = request_body["meals_time"]

        if "selected_date" in request_body:
            project_filter["date"] = request_body["selected_date"]

        list_meal = Meals.objects.filter(**project_filter)
        
        meals = []
        for item in list_meal:
            
            meals.append({"id":item.id, 
                            "name":item.name, 
                            "merchant_id":item.merchant.id, 
                            "merchant_name":item.merchant.name,
                            "price":item.price,
                            "description":item.description, 
                            "meals_time":item.meals_time.split(","),
                            "date":datetime.strptime(item.date, "%Y-%m-%d").strftime("%A, %d %b %Y"), 
                            "category":item.category,
                            "thumbnail":item.thumbnail})
            
        
        resp = json_response.render_api_success_response(meals, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK

    def get_meals_detail(self, meals_id):

        try:
            meals = Meals.objects.get(pk=meals_id)

            data = {"id":meals.id,
                    "merchant_id":meals.merchant.id,
                    "merchant_name":meals.merchant.name,
                    "name":meals.name,
                    "price":meals.price,
                    "description":meals.description, 
                    "thumbnail":meals.thumbnail,
                    "meals_time":meals.meals_time.split(",")
                    }

        except Meals.DoesNotExist:
            resp = json_response.render_api_error_response(error_message="Error data not found", status=status.HTTP_404_NOT_FOUND)
            return resp, status.HTTP_404_NOT_FOUND

        resp = json_response.render_api_success_response(data, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK

    def get_merchant_info(self, data, meals_displayed=False):

        merchant_detail = {"id":data.id, 
                "description":data.description, 
                "price":data.price,
                "name":data.name,
                "thumbnail":data.thumbnail,
                "category":data.category,
                "rating":data.rating,
                "reviews":data.reviews,
                "meals_time":data.meals_time.split(","),
                "created_at":data.created_at}

        if meals_displayed:
            list_meal = Meals.objects.filter(merchant__id=data.id).order_by('date')
            meals = []
            for item in list_meal:
                
                meals.append({"id":item.id, 
                              "name":item.name, 
                              "price":item.price,
                              "description":item.description, 
                              "meals_time":item.meals_time.split(","),
                              "date":datetime.strptime(item.date, "%Y-%m-%d").strftime("%A, %d %b %Y"), 
                              "category":item.category,
                              "thumbnail":item.thumbnail})
            
            merchant_detail["meals"] = meals

        return merchant_detail
    
    def merchant_detail(self, merchant_id):

        try:
            merchant = Merchants.objects.get(pk=merchant_id)
            merchant_detail = self.get_merchant_info(merchant, meals_displayed=True)

            resp = json_response.render_api_success_response(merchant_detail, self.start_time, total_records=1)
            return resp, status.HTTP_200_OK
        except Merchants.DoesNotExist:
            status_code = status.HTTP_404_NOT_FOUND
            resp = json_response.render_api_error_response(error_message="Data not found", status=status_code)
            return resp, status_code

    