
from django.urls import path , include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'content', views.PortfolioContentViewSet)

urlpatterns = [

    path('api/', include(router.urls)),
  
]