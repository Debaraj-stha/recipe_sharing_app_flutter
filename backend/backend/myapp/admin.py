from django.contrib import admin
from myapp.models import *
# Register your models here.
admin.site.register(User)
admin.site.register(Recipe)
admin.site.register(Reaction)
admin.site.register(Comment)
admin.site.register(RecipeMedia)
admin.site.register(Share)
admin.site.register(Follow)
from django.contrib import admin
from .models import Reaction

admin.register(Reaction)
class ReactionAdmin(admin.ModelAdmin):
    list_display = ('reacter', 'get_recipe_title', 'share', 'created_at')

    def get_recipe_title(self, obj):
        if obj.recipe:
            return obj.recipe.title
        return "No Recipe"
    get_recipe_title.short_description = 'Recipe Title'
