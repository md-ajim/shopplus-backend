from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet
from .serializers import PortfolioContentSerializer
from .models import PortfolioContent

class PortfolioContentViewSet(ModelViewSet):
    queryset = PortfolioContent.objects.all()
    serializer_class = PortfolioContentSerializer



