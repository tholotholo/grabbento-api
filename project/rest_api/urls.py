""" Rest API Router. """
from django.urls import path

from rest_api.src.modules.sample import sample_views
from rest_api.src.modules.merchants import views as merchants_views
from rest_api.src.modules.orders import views as order_views

app_name = "rest_api"
urlpatterns = [
    path('ping', sample_views.ping, name="ping"),

    path('merchants', merchants_views.get_list_merchants, name="list_merchant"),
    path('merchants/<int:merchant_id>', merchants_views.merchant_detail, name="merchant_detail"),
    path('meals', merchants_views.get_list_meals, name="list_meals"),
    path('meals/<int:meals_id>', merchants_views.detail_meals, name="detail_meals"),

    path('merchants', merchants_views.get_list_merchants, name="list_merchant"),

    path('basket', order_views.get_basket, name="get_basket"),
    path('basket/update', order_views.update_basket, name="get_basket"),

    path('pay', order_views.pay, name="pay"),
    path('orders', order_views.get_list_order, name="get_list_order"),
    path('histories', order_views.get_history_order, name="get_history_order"),
    path('orders/<int:order_id>', order_views.get_detail_order, name="get_detail_order"),
]