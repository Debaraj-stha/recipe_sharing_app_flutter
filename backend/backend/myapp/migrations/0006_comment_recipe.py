# Generated by Django 4.2 on 2023-08-27 15:42

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0005_alter_recipemedia_media'),
    ]

    operations = [
        migrations.AddField(
            model_name='comment',
            name='recipe',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='myapp.recipe'),
        ),
    ]
