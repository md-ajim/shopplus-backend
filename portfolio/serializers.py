
from rest_framework import serializers
from .models import PortfolioContent

class PortfolioContentSerializer(serializers.ModelSerializer):    
    class Meta:
        model = PortfolioContent
        fields = ('name', 'email', 'subject', 'message')

        