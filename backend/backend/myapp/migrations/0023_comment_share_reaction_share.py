# Generated by Django 4.2 on 2023-08-29 12:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0022_recipe_shareid_share_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='comment',
            name='share',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='myapp.share'),
        ),
        migrations.AddField(
            model_name='reaction',
            name='share',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='myapp.share'),
        ),
    ]
