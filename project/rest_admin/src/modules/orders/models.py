from django.db import models
from rest_admin.src.modules.merchants.models import Merchants
from rest_admin.src.modules.meals.models import Meals


class Basket(models.Model):
    merchant = models.ForeignKey(
        Merchants,
        on_delete=models.CASCADE,
        verbose_name="Merchant",
        related_name="basket_merchant_id",
        null=True,
        blank=True,
    )

    type = models.CharField("Type", max_length=150, null=True)
    duration = models.CharField("Duration", max_length=150, null=True)
    quantity = models.IntegerField("Quantity", null=True)
    meals_time = models.CharField("Meals Time", max_length=150, null=True)
    selected_date = models.CharField("Selected Date", max_length=150, null=True)
    start_date = models.CharField("Start Date", max_length=150, null=True)
    subtotal = models.IntegerField("Subtotal", null=True)
    order_fee = models.IntegerField("Order Fee", null=True)
    total = models.IntegerField("Total", null=True)

    user_id = models.IntegerField("User ID", null=True)
    
    created_at = models.DateTimeField("Created At", auto_now_add=True)

    def __str__(self):
        return "{} - {}".format(self.name, self.id)

    class Meta(object):
        """ Meta : for Basket metadata."""
        ordering = ['-created_at']
        db_table = "baskets"
        verbose_name = "Basket"
        verbose_name_plural = "Baskets"


class BasketDetail(models.Model):

    basket = models.ForeignKey(
        Basket,
        on_delete=models.CASCADE,
        verbose_name="Basket",
        related_name="barket_id",
        null=True,
        blank=True,
    )
    merchant = models.ForeignKey(
        Merchants,
        on_delete=models.CASCADE,
        verbose_name="Merchant",
        related_name="basket_detail_merchant_id",
        null=True,
        blank=True,
    )
    meals = models.ForeignKey(
        Meals,
        on_delete=models.CASCADE,
        verbose_name="Meals",
        related_name="basket_meals_id",
        null=True,
        blank=True,
    )

    quantity = models.IntegerField("Quantity", null=True)
    meals_time = models.CharField("Meals Time", max_length=150, null=True)
    date = models.CharField("Date", max_length=150, null=True)
    price = models.IntegerField("Price", null=True)
    
    created_at = models.DateTimeField("Created At", auto_now_add=True)

    def __str__(self):
        return "{} - {}".format(self.name, self.id)

    class Meta(object):
        """ Meta : for Basket metadata."""
        ordering = ['-created_at']
        db_table = "basket_detail"
        verbose_name = "Basket Detail"
        verbose_name_plural = "Basket Details"

class Orders(models.Model):

    merchant = models.ForeignKey(
        Merchants,
        on_delete=models.CASCADE,
        verbose_name="Merchant",
        related_name="order_merchant_id",
        null=True,
        blank=True,
    )

    type = models.CharField("Type", max_length=150, null=True)
    duration = models.CharField("Duration", max_length=150, null=True)
    quantity = models.IntegerField("Quantity", null=True)
    meals_time = models.CharField("Meals Time", max_length=150, null=True)
    selected_date = models.CharField("Selected Date", max_length=150, null=True)
    start_date = models.CharField("Start Date", max_length=150, null=True)
    subtotal = models.IntegerField("Subtotal", null=True)
    order_fee = models.IntegerField("Order Fee", null=True)
    total = models.IntegerField("Total", null=True)

    user_id = models.IntegerField("User ID", null=True)
    
    created_at = models.DateTimeField("Created At", auto_now_add=True)

    def __str__(self):
        return "{} - {}".format(self.name, self.id)

    class Meta(object):
        """ Meta : for Orders metadata."""
        ordering = ['-created_at']
        db_table = "orders"
        verbose_name = "Order"
        verbose_name_plural = "Orders"


class OrderDetail(models.Model):

    order = models.ForeignKey(
        Orders,
        on_delete=models.CASCADE,
        verbose_name="Orders",
        related_name="order_id",
        null=True,
        blank=True,
    )
    merchant = models.ForeignKey(
        Merchants,
        on_delete=models.CASCADE,
        verbose_name="Merchant",
        related_name="order_detail_merchant_id",
        null=True,
        blank=True,
    )
    meals = models.ForeignKey(
        Meals,
        on_delete=models.CASCADE,
        verbose_name="Meals",
        related_name="order_meals_id",
        null=True,
        blank=True,
    )

    quantity = models.IntegerField("Quantity", null=True)
    meals_time = models.CharField("Meals Time", max_length=150, null=True)
    date = models.CharField("Date", max_length=150, null=True)
    price = models.IntegerField("Price", null=True)
    
    created_at = models.DateTimeField("Created At", auto_now_add=True)

    def __str__(self):
        return "{} - {} ({})".format(self.order.id, self.meals.name, self.quantity)

    class Meta(object):
        """ Meta : for Orders metadata."""
        ordering = ['-created_at']
        db_table = "order_detail"
        verbose_name = "Order Detail"
        verbose_name_plural = "Order Details"
