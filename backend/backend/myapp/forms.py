from django import forms
from myapp.models import RecipeMedia
class uploadRecipeForm(forms.ModelForm):
    class Meta:
        model=RecipeMedia
        fields=['media','recipe']
        widgets={
            'media': forms.ClearableFileInput(attrs={'multiple':True,},)
        }
        
