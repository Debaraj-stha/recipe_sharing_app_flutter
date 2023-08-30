from myapp.models import User, Recipe, RecipeMedia, Reaction, Comment,Share
from rest_framework.decorators import api_view
from django.http import JsonResponse

from django.conf import settings

from django.core.mail import send_mail
from random import randint
from django.core import serializers

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
                        "user": {
                            "name": name,
                            "email": email,
                            "image": "",
                            "pk": user.pk,
                        },
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
                "user": {
                    "name": user[0].name,
                    "email": user[0].email,
                    "image": "",
                    "pk": user[0].pk,
                },
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
        image = data.get("image")
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
    recipes = Recipe.objects.all().order_by("created_at")
    recipe_data = []

    for recipe in recipes:
        media = RecipeMedia.objects.filter(recipe=recipe)
        comment = Comment.objects.filter(recipe=recipe)
        reaction=Reaction.objects.filter(recipe=recipe)
        mycomment = []
        reaction_data=[]
        for r in reaction:
            reaction_data.append({
                 "user": {
                    "name": r.reacter.name,
                    "email": r.reacter.email,
                    "pk":r.reacter.pk,
                    "image": str(r.reacter.image)
                },
                 "id":r.pk,
                 "created_at": r.created_at,
                 "recipeId":r.recipe.pk
                 
                 
            })
       
        media_filenames = [str(item.media) for item in media]
        myRecipe = {
            "isShare":False,
            "reaction":reaction_data,
            "totalReact":reaction.count(),
            "totalComment":comment.count(),
            "totalShare":0,
            "image": media_filenames,
            "title": recipe.title,
            "description": recipe.description,
            "steps": recipe.steps,
            "ingredients": recipe.ingredients,
            "hashtags": recipe.hastags,
            "id": recipe.pk,
            "addedAt": recipe.created_at,
            "user": {
                "name": recipe.user.name,
                "pk": recipe.user.pk,
                "email": recipe.user.email,
                "image": "",
            },
        }
        recipe_data.append(myRecipe)
        shareData=getShare()
        shareData.extend(recipe_data)
    return JsonResponse({"statusCode": 200, "recipe": shareData})



@api_view(["GET"])
def searchRecipe(request):
    q = request.GET.get("q")
    print("q " + str(q))
    recipes = Recipe.objects.filter(title__icontains=q).order_by("created_at")

    recipe_data = []

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
            "id": recipe.pk,
            "created_at": recipe.created_at,
            "user": {
                "name": recipe.user.name,
                "pk": recipe.user.pk,
                "email": recipe.user.email,
                "image": "",
            },
        }
        recipe_data.append(myRecipe)
        
    return JsonResponse({"statusCode": 200, "recipe": recipe_data})


@api_view(["POST"])
def likeRecipe(request):
    data = request.data
    print(data)
    recipeId = data.get("recipeId")
    reactorId = data.get("reactorId")
    reactor = User.objects.filter(
        pk=reactorId
    ).first() 
    recipe = Recipe.objects.filter(
        pk=recipeId
    ).first() 

    if recipe is not None:
        if reactor is not None:
            isAlreadyReact = Reaction.objects.filter(
                reacter=reactor, recipe=recipe
            )
            if isAlreadyReact.exists():
                isAlreadyReact.delete()
                return JsonResponse(
                    {
                        "status": "fail",
                        "statusCode": 400,
                        "message": "Already reacted by this user to this recipe",
                    }
                )

            reaction = Reaction(recipe=recipe, reacter=reactor)
            reaction.save()

            return JsonResponse(
                {
                    "status": "success",
                    "statusCode": 200,
                    "message": "React saved successfully",
                }
            )
        else:
            return JsonResponse(
                {"status": "fail", "statusCode": 404, "message": "User not found"}
            )
    else:
        return JsonResponse(
            {"status": "fail", "statusCode": 404, "message": "Recipe not found"}
        )


@api_view(["POST"])
def commentRecipe(request):
    data = request.data
    comment = data.get("comment")
    recipeId = data.get("recipeId")
    userId = data.get("userId")
    user = User.objects.filter(pk=userId).first()
    recipe = Recipe.objects.filter(pk=recipeId).first()
    if user is not None:
        if recipe is not None:
            commentRecipe = Comment(comment=comment, user=user, recipe=recipe)
            commentRecipe.save()
            if commentRecipe.save:
                lastComment={
                    "user":{
                    "name":commentRecipe.user.name,
                    "email":commentRecipe.user.email,
                    "pk":commentRecipe.user.pk,
                    "image": str(commentRecipe.user.image)
                    
                },
                "comment":commentRecipe.comment,
                "id":commentRecipe.pk,
                "created_at":commentRecipe.created_at
                }
               
                print(lastComment)
                return JsonResponse(
                    {"statusCode": 200, "message": "Commnent post successfully","comment": lastComment}
                )
                
            else:
                return JsonResponse(
                    {"statusCode": 400, "message": "Commnent is not post successfully"}
                )
        else:
            return JsonResponse({"statusCode": 404, "message": "Recipe not found"})
    else:
        return JsonResponse({"statusCode": 404, "message": "User not found"})

@api_view(['GET'])
def loadComment(request):
    pk=request.GET.get('pk')
    recipe=Recipe.objects.filter(pk=pk).first()
    print(recipe)
    comments=Comment.objects.filter(recipe=recipe)
    if comments.exists():
        commentList=[]
        for comment in comments:
            commentList.append({
                "user":{
                    "name":comment.user.name,
                    "email":comment.user.email,
                    "pk":comment.user.pk,
                    "image": str(comment.user.image)
                    
                },
                "comment":comment.comment,
                "id":comment.pk,
                "created_at":comment.created_at
            })
        
        return JsonResponse({"statusCode":200,"message":"success","comments":commentList})
    else:
        return JsonResponse({"statusCode": 404, "message":"No commnent yet"})
@api_view(['POST'])
def changeProfile(request):
    data=request.data
    image=data.get('image')
    userId=data.get('userId')
    user=User.objects.filter(pk=userId).first()
    if user is not None:
        user.image=image
        user.save()
        if user.save:
            return JsonResponse({"statusCode":200,"message":"profile updated successfully"})
        else:
            return JsonResponse({"statusCode":400,"message":"something went wrong"})
    else:
        return JsonResponse({"statusCode":404,"message":"user not found"})
@api_view(['POST'])
def shareRecipe(request):
    data=request.data
    userId=data.get('userId')
    print(userId)
    recipeId=data.get('recipeId')
    title=data.get('title')
    user=User.objects.filter(pk=userId).first()
    recipe=Recipe.objects.filter(pk=recipeId).first()
    print(user.name)
    
    print(recipe)
    if user is not None and recipe is not None:
        recipeOwnerPk=recipe.user.pk
        print(recipeOwnerPk)
        recipeOwner=User.objects.filter(pk=recipeOwnerPk).first()
        print(recipeOwner)
        share=Share(recipe=recipe,recipeOwner=recipeOwner,title=title,user=user)
        share.save()
        shareId=Recipe(title=title,shareId=share,user=user)
        shareId.save()
        if share.save:
            return JsonResponse({'message':"resipe is shared succcessfully","statusCode":200})
    else:
        return JsonResponse({"statusCode":404,"message":"Either user or recipe is invalid"})


def getShare():
    share=Share.objects.all()
    shareList=[]
    for s in share:
        shareRecipe=Recipe.objects.filter(pk=s.pk).first()
        comment=Comment.objects.filter(recipe=shareRecipe)
        reaction=Reaction.objects.filter(recipe=shareRecipe)
        media = RecipeMedia.objects.filter(recipe=shareRecipe)
        media_filenames = [str(item.media) for item in media]
        shareList.append({
             "reaction":[],
            "image":media_filenames,
            "isShare":True,
            "totalReact":reaction.count(),
            "totalComment":comment.count(),
            "sharetitle":s.title,
            "title":s.recipe.title,
            "description":s. recipe.description,
            "steps":s. recipe.steps,
            "ingredients":s. recipe.ingredients,
            "hashtags":s. recipe.hastags,
            "id":s. recipe.pk,
            "addedAt":s. recipe.created_at,
            "user": {
                "name":s.user.name,
                "pk":s.user.pk,
                "email":s.user.email,
                "image": "",
            },
            "owner":{
                 "name":s.recipeOwner.name,
                "pk":s. recipeOwner.pk,
                "email":s. recipeOwner.email,
                "image": "",
            }
        })
    return shareList
def getUser():
    user=User.objects.all()
    users=serializers.serialize('json',user)
    print(users)
getUser()