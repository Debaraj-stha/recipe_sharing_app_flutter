from django.urls import path, include
from myapp import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path("upload-recipe", views.uploadRecipe, name="upload-recipe"),
    path("signup", views.signup, name="signup"),
    path("get-recipe", views.getMyRecipe, name="recipe"),
    path("login", views.login, name="login"),
    path("search-recipe", views.searchRecipe, name="search"),
    path("like-recipe", views.likeRecipe, name="like-recipe"),
    path('comment-recipe', views.commentRecipe, name="comment-recipe"),
    path('loadComment', views.loadComment, name="load-comment"),
    path("change-profile", views.changeProfile, name="change-profile"),
    path('share-recipe',views.shareRecipe, name="share-recipe"),
    path('get-share', views.getShare, name="get-share"),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
