# Generated by Django 4.2 on 2023-08-29 10:44

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0013_recipe_shareid'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='recipe',
            name='shareId',
        ),
        migrations.DeleteModel(
            name='Share',
        ),
    ]
