from django.contrib import admin
from .models import PortfolioContent
from unfold.admin import ModelAdmin
from simple_history.admin import SimpleHistoryAdmin

class UnfoldAdminPanel(SimpleHistoryAdmin , ModelAdmin):
    pass    

@admin.register(PortfolioContent)
class PortfolioContentAdmin(UnfoldAdminPanel):
    pass
