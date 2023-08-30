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
    image=models.ImageField(upload_to="profile-image/",null=True, blank=True,max_length=100)
    
    # def __str__(self) -> str:
    #     return  self.name



class Recipe(models.Model):
    title = models.CharField(max_length=150, null=True,blank=True)
    description = models.TextField(null=True, blank=True,)
    steps = ArrayField(base_field=models.CharField(max_length=250), blank=True, null=True, default=list)
    ingredients = ArrayField(base_field=models.CharField(max_length=100), blank=True, null=True, default=list)
    hastags = ArrayField(base_field=models.CharField(max_length=50), blank=True, null=True, default=list)
    created_at = models.DateTimeField(auto_now_add=True, null=True)
    updated_at = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE)
    shareId = models.ForeignKey('Share', null=True, blank=True, on_delete=models.CASCADE, related_name='shared_recipes')  # Updated related_name

class Share(models.Model):
    title=models.CharField(max_length=150,null=True,blank=True)
    user = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE, related_name='shared_user')
    recipe = models.ForeignKey(Recipe, null=True, blank=True, on_delete=models.CASCADE)
    recipeOwner = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE, related_name='shared_recipe_owner')

    

    
    
class RecipeMedia(models.Model):
    media = models.ImageField(upload_to="post-image/", max_length=100,null=True,blank=True)
    recipe = models.ForeignKey(Recipe, null=True, blank=True, on_delete=models.CASCADE)
    
    # def __str__(self):
    #     return self.recipe.title

class Reaction(models.Model):
    created_at = models.DateTimeField(auto_now_add=True, null=True)
    reacter = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE)
    share=models.ForeignKey(Share, null=True, blank=True, on_delete=models.CASCADE)
    recipe = models.ForeignKey(Recipe, null=True, blank=True, on_delete=models.CASCADE)
    

class Comment(models.Model):
    created_at = models.DateTimeField(auto_now_add=True, null=True)
    comment = models.TextField()
    share=models.ForeignKey(Share, null=True, blank=True, on_delete=models.CASCADE)
    user = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE)
    recipe = models.ForeignKey(Recipe, null=True, blank=True, on_delete=models.CASCADE)

   


