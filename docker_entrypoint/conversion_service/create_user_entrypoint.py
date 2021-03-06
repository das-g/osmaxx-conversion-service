import sys, os
sys.path.append('/home/py/conversion_service')
os.environ['DJANGO_SETTINGS_MODULE'] = os.getenv('DJANGO_SETTINGS_MODULE')

from django.contrib.auth.models import User

username = os.getenv('SERVICE_USER_NAME', None)
password = os.getenv('SERVICE_USER_PASSWORD', None)

print('user creation')

def create_user(user_name, user_password):
    print('user creation')
    try:
        user = User.objects.get(username=user_name)
        print('changing user_password for existing user %s' % user.username)
        user.set_password(user_password)
        print('user user_password changed')
    except User.DoesNotExist:
        print('creating new user')
        user = User.objects.create_user(username=user_name, password=user_password, email='')
        print('user: %s created' % user.username)
    print('user creation done')


if username and password:
    create_user(username, password)
else:
    print('no user created')
