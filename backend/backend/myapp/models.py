import os
from django.conf import settings
from django.db import models
from django.contrib.postgres.fields import ArrayField


class User(models.Model):
    name = models.CharField(max_length=30)
    email = models.EmailField(max_length=30, unique=True)
    password = models.CharField(max_length=30)
    created_at = models.DateTimeField(auto_now_add=True, null=True)
    updated_at = models.DateTimeField(auto_now=True, null=True)
    def __str__(self):
        return self.email

class Recipe(models.Model):
    title = models.CharField(max_length=150, null=True)
    description = models.TextField()
    steps = ArrayField(base_field=models.CharField(max_length=250), blank=True, null=True, default=list)
    ingredients = ArrayField(base_field=models.CharField(max_length=100), blank=True, null=True, default=list)
    hastags = ArrayField(base_field=models.CharField(max_length=50), blank=True, null=True, default=list)
    created_at = models.DateTimeField(auto_now_add=True, null=True)
    updated_at = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.title

    
    
class RecipeMedia(models.Model):
    media = models.ImageField(upload_to="post-image/", max_length=100,null=True,blank=True)
    recipe = models.ForeignKey(Recipe, null=True, blank=True, on_delete=models.CASCADE)
    def __str__(self):
        return self.recipe.title

class Reaction(models.Model):
    created_at = models.DateTimeField(auto_now_add=True, null=True)
    reacter = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE)

    recipe = models.ForeignKey(Recipe, null=True, blank=True, on_delete=models.CASCADE)
    def __str__(self):
        return self.recipe.title

class Comment(models.Model):
    created_at = models.DateTimeField(auto_now_add=True, null=True)
    comment = models.CharField(max_length=150)
    user = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE)
    def __str__(self):
        return self.recipe.title
