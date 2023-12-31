# Generated by Django 4.2 on 2023-08-29 11:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0021_remove_recipe_shareid'),
    ]

    operations = [
        migrations.AddField(
            model_name='recipe',
            name='shareId',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='shared_recipes', to='myapp.share'),
        ),
        migrations.AddField(
            model_name='share',
            name='user',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='shared_user', to='myapp.user'),
        ),
    ]
