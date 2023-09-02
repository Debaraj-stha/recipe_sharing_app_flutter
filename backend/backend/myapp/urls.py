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
    path('get-user-recipe', views.getSpecificUserRecipe, name="get-user-recipe"),
    path('follow-user', views.followUser, name="follow-user"),
    path('follow-user',views.followUser, name="follow-user"),
    path('unfollow-user', views.unfollowUser, name="unfollow-user"),
    path('get-following-user', views.getFollowing, name="get-following-user"),
    path('get-follow-user', views.getFollower, name="get-follow-user"),
    path('report-content', views.reportContent, name="report-content"),
    path('block-user', views.blockUser, name="block-user"),
    path('verify-otp', views.verifyOTP, name="veryfy-otp"),
    path('send-email', views.sendEmail, name="send-email"),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
