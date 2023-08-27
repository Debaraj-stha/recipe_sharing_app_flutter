from django.urls import path,include
from myapp import views
from django.conf  import settings
from django.conf.urls.static import static
urlpatterns = [
   path('upload-recipe',views.uploadRecipe,name="upload-recipe"),
    path('signup',views.signup,name='signup'),
    path('get-recipe',views.getRecipe,name='recipe'),
    path('login',views.login,name='login'),
]+static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)