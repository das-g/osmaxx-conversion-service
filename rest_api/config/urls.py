from django.conf.urls import include, url
from rest_framework import routers
from converter import views

router = routers.DefaultRouter()
router.register(r'conversions/bbox', views.ConverterBBoxJobViewSet)


urlpatterns = [
    # browsable REST API
    url(r'^', include(router.urls)),
    url(r'^django-rq/', include('django_rq.urls')),
    url(r'^api/auth/', include('rest_framework.urls', namespace='rest_framework')),

    url(r'^api/token-auth/$', 'rest_framework_jwt.views.obtain_jwt_token'),
    url(r'^api/token-refresh/$', 'rest_framework_jwt.views.refresh_jwt_token'),
    url(r'^api/token-verify/$', 'rest_framework_jwt.views.verify_jwt_token'),
]
