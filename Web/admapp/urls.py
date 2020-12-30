from django.urls import path
from . import views

urlpatterns=[
    path('login/',views.login,name='login'),
    path('accept/',views.accept,name='accept'),
    path('clubid/',views.clubid,name='clubid'),
    
    path('addcc/',views.addcc,name='addcc'),
    path('adc/',views.adc,name='adc'),
    
    path('addclub/',views.addclub,name='addclub'),
    path('vc/',views.vc,name='vc'),
    path('viewcc/',views.viewcc,name='viewcc'),
    path('viewevent/',views.viewevent,name='viewevent'),
    path('logout/',views.logout,name='logout')
]