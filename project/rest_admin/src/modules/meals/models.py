from django.db import models
from rest_admin.src.modules.merchants.models import Merchants

class Meals(models.Model):

    merchant = models.ForeignKey(
        Merchants,
        on_delete=models.CASCADE,
        verbose_name="Merchant",
        related_name="merchant_id"
    )
    name = models.CharField("Name", max_length=150, null=False)
    category = models.CharField("Category", max_length=150, null=False)
    meals_time = models.CharField("Name", max_length=250, null=False)
    date = models.CharField("Date", max_length=250, null=True)
    thumbnail = models.TextField("Thumbnail", null=False)
    description = models.TextField("Description", null=True)
    price = models.IntegerField("Price", null=True)
    
    created_at = models.DateTimeField("Created At", auto_now_add=True)

    def __str__(self):
        return "{} - {}".format(self.name, self.id)

    class Meta(object):
        """ Meta : for Meals metadata."""
        ordering = ['-created_at']
        db_table = "meals"
        verbose_name = "Meals"
        verbose_name_plural = "Meals"
