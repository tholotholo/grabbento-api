from django.contrib import admin

from rest_admin.src.modules.meals.models import Meals
from rest_admin.src.modules.merchants.models import Merchants
from rest_admin.src.modules.orders.models import Orders, OrderDetail, Basket, BasketDetail

# Register your models here.
admin.site.register(Meals)
admin.site.register(Merchants)
admin.site.register(Orders)
admin.site.register(OrderDetail)
admin.site.register(Basket)
admin.site.register(BasketDetail)
