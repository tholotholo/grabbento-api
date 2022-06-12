from django.db import models

class Merchants(models.Model):

    name = models.CharField("Name", max_length=150, null=False)
    category = models.CharField("Category", max_length=150, null=False)
    description = models.TextField("Description", null=True)
    meals_time = models.CharField("Name", max_length=250, null=True)
    thumbnail = models.TextField("Thumbnail", null=False)
    price = models.IntegerField("Price", null=True)
    reviews = models.CharField("Reviews", max_length=250, null=True)
    rating = models.CharField("Rating", max_length=250, null=True)
    
    created_at = models.DateTimeField("Created At", auto_now_add=True)

    def __str__(self):
        return "{} - {}".format(self.name, self.id)

    class Meta(object):
        """ Meta : for Merchants metadata."""
        ordering = ['-created_at']
        db_table = "merchants"
        verbose_name = "Merchant"
        verbose_name_plural = "Merchants"
