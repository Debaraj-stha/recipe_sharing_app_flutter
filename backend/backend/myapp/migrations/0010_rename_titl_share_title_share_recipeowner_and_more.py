# Generated by Django 4.2 on 2023-08-29 09:51

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0009_share'),
    ]

    operations = [
        migrations.RenameField(
            model_name='share',
            old_name='titl',
            new_name='title',
        ),
        migrations.AddField(
            model_name='share',
            name='recipeOwner',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='shared_recipe_owner', to='myapp.user'),
        ),
        migrations.AlterField(
            model_name='share',
            name='user',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='shared_user', to='myapp.user'),
        ),
    ]
