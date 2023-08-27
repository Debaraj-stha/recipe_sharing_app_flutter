from django.shortcuts import render, HttpResponse
from myapp.models import User, Recipe, RecipeMedia
from rest_framework.decorators import api_view
from django.http import JsonResponse
import os
from django.conf import settings
from django.core import serializers
from django.db.models import Count, F
from django.core.mail import send_mail
from random import randint
from django.utils import timezone
from datetime import timedelta
# Create your views here.
@api_view(["POST"])
def signup(request):
    if request.method == "POST":
        data = request.data
        name = data.get("name")
        email = data.get("email")
        password = data.get("password")
        user = User.objects.filter(email=email, password=password)
        if user.exists():
            return JsonResponse(
                {"success": False, "statusCode": 400, "message": "User already exists"}
            )
        else:
            user = User(name=name, email=email, password=password)
            user.save()

            if user.save:
                return JsonResponse(
                    {
                        "success": True,
                        "statusCode": 200,
                        "message": "Signup successfully",
                        "user": {"name": name, "email": email, "image": "","pk":user.pk},
                    }
                )
            else:
                return JsonResponse(
                    {
                        "success": False,
                        "statusCode": 400,
                        "message": "Signup Failed.Please try again later",
                    }
                )


@api_view(["POST"])
def login(request):
    data = request.data
    email = data.get("email")
    password = data.get("password")
    user = User.objects.filter(email=email, password=password)
    if user.exists():
        return JsonResponse(
            {
                "success": True,
                "statusCode": 200,
                "user": {"name": user[0].name, "email": user[0].email, "image": "","pk":user[0].pk},
                "message": "Login successfully",
            }
        )
    else:
        return JsonResponse(
            {
                "success": False,
                "statusCode": 400,
                "message": "Either email or password is invalid",
            }
        )


@api_view(["POST"])
def sendMail(request):
    mailto = request.data.get("mailto")
    otp = randint(100000, 99999)
    subject = "Account verification code"
    message = f"Verify your account with this otp.This otp will expire  after 5 minutes.<center><strong>{otp}</strong></center>"
    mailFrom = (settings.EMAIL_HOST_USER,)
    status = send_mail(
        subject, message, mailFrom, [mailto], fail_silently=False, html_message=message
    )
    print(status)
    return JsonResponse({"status": status})
    # if status.


def home(request):
    return JsonResponse({"success": True, "statusCode": 200})


@api_view(["POST"])
def uploadRecipe(request):
    try:
        data = request.data
        email = data.get("email")
        image=data.get("image")
        print("image")
        print(image)
        # uploadForm = uploadRecipeForm(request.POST, request.FILES)

        if email is not None:
            user = User.objects.get(email=email)
            print(user.email)
            if user.email is None:
                return JsonResponse(
                    {
                        "success": False,
                        "statusCode": 400,
                        "mesage": "invalid user details",
                    }
                )
            else:
                title = data.get("title")
                description = data.get("description")
                hastags = data.get("hastags").split(" ")
                ingredients = data.get("ingredients").split(",")
                steps = data.get("steps").split(".")
                recipe = Recipe.objects.create(
                    user=user,
                    title=title,
                    description=description,
                    hastags=hastags,
                    ingredients=ingredients,
                    steps=steps,
                )
                recipe.save()

                for image in request.FILES.getlist("image"):
                    recipeMedia = RecipeMedia.objects.create(recipe=recipe, media=image)
                    recipeMedia.save()
                return JsonResponse(
                    {
                        "success": True,
                        "statusCode": 200,
                        "message": "Recipe uploaded successfully",
                    }
                )
                # uploadForm.save()

        else:
            return JsonResponse(
                {
                    "success": False,
                    "statusCode": 400,
                    "message": "Something went wrong. Please try again leter",
                }
            )
    except ValueError as e:
        return JsonResponse({"success": False, "statusCode": 400, "message": str(e)})


@api_view(["GET"])
def getRecipe(request):
    recipes = Recipe.objects.all()
    recipe_data = []
    now=timezone.now()
    for recipe in recipes:
        media = RecipeMedia.objects.filter(recipe=recipe)
        media_filenames = [str(item.media) for item in media]
        myRecipe = {
            "image": media_filenames,
            "title": recipe.title,
            "description": recipe.description,
            "steps": recipe.steps,
            "ingredients": recipe.ingredients,
            "hastags": recipe.hastags,
            "id":recipe.pk,
            "created_at": recipe.created_at,
            "user":{
                "name":recipe.user.name,
                "pk": recipe.user.pk,
                "email": recipe.user.email,
                "image":""
            }
        }
        recipe_data.append(myRecipe)

    return JsonResponse({"statusCode": 200, "recipe": recipe_data})
