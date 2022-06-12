import logging
from datetime import datetime, timedelta

from django.conf import settings
from django.db.models import Sum
from rest_framework import status

from rest_admin.src.modules.orders.models import Basket, BasketDetail, Orders, OrderDetail
from rest_admin.src.modules.meals.models import Meals

from vendor.errors import error_message
from vendor.helper import helper
from vendor.template import json_response

import random

USER_ID = 123

logger = logging.getLogger(__name__)

class OrdersHandler():

    def __init__(self, start_time):
        self.start_time = start_time
        
    def get_basket(self):
        
        default_resp = {
            "user_id" : USER_ID,
            "type":"empty",
            "subtotal":0,
            "order_fee":0,
            "total": 0,
            "duration":None, 
            "quantity":None,
            "meals_time":None,
            "meals":[]
            }

        try:
            basket = Basket.objects.get(user_id=USER_ID)
            basket_info = self.get_basket_info(basket)

        except Basket.DoesNotExist as e:
            basket_info = default_resp
           

        resp = json_response.render_api_success_response(basket_info, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK

    def get_basket_info(self, basket):
        basket_info = {
                "user_id" : USER_ID,
                "duration" : basket.duration,
                "merchant_id" : basket.merchant_id,
                "quantity" : basket.quantity,
                "selected_date" : basket.selected_date,
                "start_date" : basket.start_date,
                "type" : basket.type,
                "meals_time" : basket.meals_time,
                "order_fee" : 6000,
                "meals": []
            }

        subtotal = 0
        
        item_basket = BasketDetail.objects.filter(basket__id=basket.id).order_by("date")
        for item in item_basket:
            basket_info["meals"].append({
                "menu_id" : item.meals.id,
                "name" : item.meals.name,
                "merchant_name" : item.meals.merchant.name,
                "merchant_id" : item.meals.merchant.id,
                "price" : item.price,
                "date" : datetime.strptime(item.date, "%Y-%m-%d").strftime("%A, %d %b %Y"),
                "quantity" : item.quantity,
                "thumbnail" : item.meals.thumbnail,
                "meals_time" : item.meals_time
            })

            subtotal += item.quantity * item.price

        total = 6000 + subtotal
        basket_info["subtotal"] = subtotal
        basket_info["total"] = total

        return basket_info

    def update_basket(self, request_body):

        try:
            if request_body["type"] == "daily":
                basket_clean = Basket.objects.filter(user_id=USER_ID)
                basket_clean.delete()

                basket = Basket()
                basket.selected_date = request_body["selected_date"]
                basket.start_date = request_body["selected_date"]
                basket.type = "daily"
                basket.user_id = USER_ID
                basket.save()

                for item in request_body["meals"]:
                    basket_detail = BasketDetail()
                    basket_detail.basket_id = basket.id
                    basket_detail.meals_id = item["menu_id"]
                    basket_detail.meals_time = item["meals_time"]
                    basket_detail.quantity = item["quantity"]
                    basket_detail.date = request_body["selected_date"]
                    basket_detail.price = Meals.objects.get(id=item["menu_id"]).price
                    basket_detail.save()

                basket_info = self.get_basket_info(basket)
            elif request_body["type"] == "package":
                basket_clean = Basket.objects.filter(user_id=USER_ID)
                basket_clean.delete()

                basket = Basket()
                basket.start_date = request_body["start_date"]
                basket.quantity = request_body["quantity"]
                basket.duration = request_body["duration"]
                basket.type = "package"
                basket.merchant_id = request_body["merchant_id"]
                basket.meals_time = request_body["meals_time"]
                basket.user_id = USER_ID
                basket.save()

                date_meals = []
                start_date = datetime.strptime(request_body["start_date"], "%Y-%m-%d")
                i = 0
                while i < request_body["duration"]:
                    date_meals.append((start_date + timedelta(days=i)).strftime("%Y-%m-%d"))
                    i += 1

                meals_from_merchant = Meals.objects.filter(merchant__id=request_body["merchant_id"], date__in=date_meals).order_by("date")

                for item in meals_from_merchant:
                    basket_detail = BasketDetail()
                    basket_detail.basket_id = basket.id
                    basket_detail.meals_id = item.id
                    basket_detail.meals_time = request_body["meals_time"]
                    basket_detail.quantity = request_body["quantity"]
                    basket_detail.date = item.date
                    basket_detail.price = item.price
                    basket_detail.save()

                basket_info = self.get_basket_info(basket)

            elif request_body["type"] == "empty" or request_body["meals"] == []:
                basket = Basket.objects.filter(user_id=USER_ID)
                basket.delete()

                basket_info = {
                    "user_id" : USER_ID,
                    "type":"empty",
                    "subtotal":0,
                    "order_fee":0,
                    "total": 0,
                    "duration":None, 
                    "quantity":None,
                    "meals_time":None,
                    "meals":[]
                }
                
            else:
                raise ValueError("invalid type")
            
            
        except Exception as e:
            resp = json_response.render_api_error_response("Issue happens on server", [str(e)], self.start_time,
                                                               request_body, status.HTTP_500_INTERNAL_SERVER_ERROR)
            return resp, status.HTTP_500_INTERNAL_SERVER_ERROR

        resp = json_response.render_api_success_response(basket_info, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK

    def pay(self, request_body):

        try:
            {"type":"normal"} 

            if request_body["type"] == "normal": 
                basket = Basket.objects.get(user_id=USER_ID)

                user_basket = self.get_basket_info(basket)

                order = Orders()
                order.start_date = user_basket["start_date"]
                order.selected_date = user_basket["selected_date"]
                order.quantity = user_basket["quantity"]
                order.duration = user_basket["duration"]
                order.type = user_basket["type"]
                order.merchant_id = user_basket["merchant_id"]
                order.meals_time = user_basket["meals_time"]
                order.total = user_basket["total"]
                order.subtotal = user_basket["subtotal"]
                order.order_fee = user_basket["order_fee"]
                order.user_id = USER_ID
                order.save()

                for item in user_basket["meals"]:

                    date = datetime.strptime(item["date"], "%A, %d %b %Y").strftime("%Y-%m-%d")
                    order_detail = OrderDetail()
                    order_detail.meals_id = item["menu_id"]
                    order_detail.merchant_id = item["merchant_id"]
                    order_detail.order = order
                    order_detail.quantity = item["quantity"]
                    order_detail.meals_time = item["meals_time"]
                    order_detail.date = date
                    order_detail.price = item["price"]
                    order_detail.save()


                # clear basket
                basket.delete()

                order_data = self.get_order_info(order)
            
            elif request_body["type"] == "mystery":

                subtotal = request_body["quantity"] * 30000
                total = subtotal + 6000
                order = Orders()
                order.start_date = request_body["start_date"]
                order.quantity = request_body["quantity"]
                order.duration = request_body["duration"]
                order.type = "mysterious"
                order.meals_time = request_body["meals_time"]
                order.total = total
                order.subtotal = subtotal
                order.order_fee = 6000
                order.user_id = USER_ID
                order.save()

                start_date = datetime.strptime(request_body["start_date"], "%Y-%m-%d")
                i = 0

                meals_mystery = Meals.objects.get(category="Mystery")
                
                while i < request_body["duration"]:
                    
                    date = (start_date + timedelta(days=i)).strftime("%Y-%m-%d")
                    order_detail = OrderDetail()
                    order_detail.order_id = order.id
                    order_detail.merchant_id = meals_mystery.merchant.id
                    order_detail.meals_id = meals_mystery.id
                    order_detail.price = meals_mystery.price
                    order_detail.quantity = request_body["quantity"]
                    order_detail.date = date
                    order_detail.meals_time = request_body["meals_time"]
                    order_detail.save()
                    
                    i += 1

                order_data = self.get_order_info(order)

        except Basket.DoesNotExist as e:
            resp = json_response.render_api_success_response({"status":"empty"}, self.start_time, total_records=1)
            return resp, status.HTTP_200_OK

        except Exception as e:
            resp = json_response.render_api_error_response(error_message="Internal server error. {}".format(str(e)), status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            return resp, status.HTTP_500_INTERNAL_SERVER_ERROR
           
        resp = json_response.render_api_success_response(order_data, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK
    
    def get_list_order(self):
        
        today = datetime.now().strftime("%Y-%m-%d")
        orders = Orders.objects.filter(user_id=USER_ID, start_date__gte=today)
        list_order = []

        for order in orders:
            list_order.append(self.get_order_info(order))
           
        resp = json_response.render_api_success_response(list_order, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK

    def get_history_order(self):
        today = datetime.now().strftime("%Y-%m-%d")
        current_month = datetime.now().strftime("%b")
        orders = Orders.objects.filter(user_id=USER_ID)
        list_order = {}

        for order in orders:

            time_order = order.created_at.strftime("%b")
            if current_month == time_order:
                time_order = "This month"
            
            if time_order not in list_order:
                list_order[time_order] = []

            list_order[time_order].append(self.get_order_info(order))

        resp = json_response.render_api_success_response(list_order, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK



    def get_order_info(self, order):

        order_detail = {
            "id" : order.id,
            "duration" : order.duration,
            "order_date" : order.start_date,
            "amount" : order.total,
            "merchant_id" : None if order.merchant_id is None else order.merchant.id,
            "merchant_name" : None if order.merchant_id is None else order.merchant.name,
            "type" : order.type,
            "subtotal" : order.subtotal,
            "order_fee" : order.order_fee,
            "quantity" : order.quantity,
            "order_details" : []
        }

        meals_ordered = 0

        items = OrderDetail.objects.filter(order__id=order.id)
        for item in items:
            order_detail["order_details"].append({"menu_id" : item.meals.id,
                "name" : item.meals.name,
                "merchant_name" : item.meals.merchant.name,
                "merchant_id" : item.meals.merchant.id,
                "price" : item.price,
                "date" : datetime.strptime(item.date, "%Y-%m-%d").strftime("%A, %d %b %Y"),
                "quantity" : item.quantity,
                "thumbnail" : item.meals.thumbnail,
                "meals_time" : item.meals_time})

            meals_ordered += 1

        if order.type == "package":
            order_detail["title"] = order.merchant.name
            order_detail["subtitle"] = "{} - {} Days".format(order.type.title(), order.duration)
        elif order.type == "daily":
            order_detail["title"] = "{} Meals Ordered".format(meals_ordered)
            order_detail["subtitle"] = "{}".format(order.type.title())

        return order_detail

    def get_order_detail(self, order_id):

        try:
            order_data = Orders.objects.get(id=order_id)
            order_detail = self.get_order_info(order_data)

        except Orders.DoesNotExist as e:
            resp = json_response.render_api_error_response(error_message="Error data not found", status=status.HTTP_404_NOT_FOUND)
            return resp, status.HTTP_404_NOT_FOUND
           

        resp = json_response.render_api_success_response(order_detail, self.start_time, total_records=1)
        return resp, status.HTTP_200_OK



    