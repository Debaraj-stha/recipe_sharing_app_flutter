# Generated by Django 4.2 on 2023-08-26 06:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0004_rename_hastag_recipe_hastags_recipe_updated_at_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='recipemedia',
            name='media',
            field=models.ImageField(blank=True, null=True, upload_to='post-image/'),
        ),
    ]