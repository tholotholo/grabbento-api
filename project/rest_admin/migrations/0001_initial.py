# Generated by Django 3.1.3 on 2022-06-10 22:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Basket',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(max_length=150, null=True, verbose_name='Type')),
                ('duration', models.CharField(max_length=150, null=True, verbose_name='Duration')),
                ('quantity', models.IntegerField(null=True, verbose_name='Quantity')),
                ('meals_time', models.CharField(max_length=150, null=True, verbose_name='Meals Time')),
                ('selected_date', models.CharField(max_length=150, null=True, verbose_name='Selected Date')),
                ('subtotal', models.IntegerField(null=True, verbose_name='Subtotal')),
                ('order_fee', models.IntegerField(null=True, verbose_name='Order Fee')),
                ('total', models.IntegerField(null=True, verbose_name='Total')),
                ('user_id', models.IntegerField(null=True, verbose_name='User ID')),
                ('created_at', models.DateTimeField(auto_now_add=True, verbose_name='Created At')),
            ],
            options={
                'verbose_name': 'Basket',
                'verbose_name_plural': 'Baskets',
                'db_table': 'baskets',
                'ordering': ['-created_at'],
            },
        ),
        migrations.CreateModel(
            name='Meals',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=150, verbose_name='Name')),
                ('category', models.CharField(max_length=150, verbose_name='Category')),
                ('meals_time', models.CharField(max_length=250, verbose_name='Name')),
                ('thumbnail', models.TextField(verbose_name='Thumbnail')),
                ('price', models.IntegerField(null=True, verbose_name='Price')),
                ('created_at', models.DateTimeField(auto_now_add=True, verbose_name='Created At')),
            ],
            options={
                'verbose_name': 'Meals',
                'verbose_name_plural': 'Meals',
                'db_table': 'meals',
                'ordering': ['-created_at'],
            },
        ),
        migrations.CreateModel(
            name='Merchants',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=150, verbose_name='Name')),
                ('category', models.CharField(max_length=150, verbose_name='Category')),
                ('meals_time', models.CharField(max_length=250, verbose_name='Name')),
                ('thumbnail', models.TextField(verbose_name='Thumbnail')),
                ('price', models.IntegerField(null=True, verbose_name='Price')),
                ('created_at', models.DateTimeField(auto_now_add=True, verbose_name='Created At')),
            ],
            options={
                'verbose_name': 'Merchant',
                'verbose_name_plural': 'Merchants',
                'db_table': 'merchants',
                'ordering': ['-created_at'],
            },
        ),
        migrations.CreateModel(
            name='Orders',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(max_length=150, null=True, verbose_name='Type')),
                ('duration', models.CharField(max_length=150, null=True, verbose_name='Duration')),
                ('quantity', models.IntegerField(null=True, verbose_name='Quantity')),
                ('meals_time', models.CharField(max_length=150, null=True, verbose_name='Meals Time')),
                ('selected_date', models.CharField(max_length=150, null=True, verbose_name='Selected Date')),
                ('subtotal', models.IntegerField(null=True, verbose_name='Subtotal')),
                ('order_fee', models.IntegerField(null=True, verbose_name='Order Fee')),
                ('total', models.IntegerField(null=True, verbose_name='Total')),
                ('user_id', models.IntegerField(null=True, verbose_name='User ID')),
                ('created_at', models.DateTimeField(auto_now_add=True, verbose_name='Created At')),
                ('merchant', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='order_merchant_id', to='rest_admin.merchants', verbose_name='Merchant')),
            ],
            options={
                'verbose_name': 'Order',
                'verbose_name_plural': 'Orders',
                'db_table': 'orders',
                'ordering': ['-created_at'],
            },
        ),
        migrations.CreateModel(
            name='OrderDetail',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField(null=True, verbose_name='Quantity')),
                ('meals_time', models.CharField(max_length=150, null=True, verbose_name='Meals Time')),
                ('date', models.CharField(max_length=150, null=True, verbose_name='Date')),
                ('price', models.IntegerField(null=True, verbose_name='Price')),
                ('created_at', models.DateTimeField(auto_now_add=True, verbose_name='Created At')),
                ('meals', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='order_meals_id', to='rest_admin.meals', verbose_name='Meals')),
                ('merchant', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='order_detail_merchant_id', to='rest_admin.merchants', verbose_name='Merchant')),
                ('order', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='order_id', to='rest_admin.orders', verbose_name='Orders')),
            ],
            options={
                'verbose_name': 'Order Detail',
                'verbose_name_plural': 'Order Details',
                'db_table': 'order_detail',
                'ordering': ['-created_at'],
            },
        ),
        migrations.AddField(
            model_name='meals',
            name='merchant',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='merchant_id', to='rest_admin.merchants', verbose_name='Merchant'),
        ),
        migrations.CreateModel(
            name='BasketDetail',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField(null=True, verbose_name='Quantity')),
                ('meals_time', models.CharField(max_length=150, null=True, verbose_name='Meals Time')),
                ('date', models.CharField(max_length=150, null=True, verbose_name='Date')),
                ('price', models.IntegerField(null=True, verbose_name='Price')),
                ('created_at', models.DateTimeField(auto_now_add=True, verbose_name='Created At')),
                ('basket', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='barket_id', to='rest_admin.basket', verbose_name='Basket')),
                ('meals', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='basket_meals_id', to='rest_admin.meals', verbose_name='Meals')),
                ('merchant', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='basket_detail_merchant_id', to='rest_admin.merchants', verbose_name='Merchant')),
            ],
            options={
                'verbose_name': 'Basket Detail',
                'verbose_name_plural': 'Basket Details',
                'db_table': 'basket_detail',
                'ordering': ['-created_at'],
            },
        ),
        migrations.AddField(
            model_name='basket',
            name='merchant',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='basket_merchant_id', to='rest_admin.merchants', verbose_name='Merchant'),
        ),
    ]
