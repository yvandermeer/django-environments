from .. import *
from os import path


DATABASE_ENGINE = 'postgresql'
DATABASE_HOST = ''
DATABASE_NAME = ''
DATABASE_USER = ''
DATABASE_PASSWORD = ''

DEBUG = False

SERVE_MEDIA = False

COMPRESS = True

SEND_BROKEN_LINK_EMAILS = False

ROSETTA_WSGI_AUTO_RELOAD = True

GOOGLE_ANALYTICS_CODE = 'UA-XXX'

CACHE_BACKEND = 'memcached://127.0.0.1:11211/'
CACHE_MIDDLEWARE_SECONDS = 60
CACHE_MIDDLEWARE_ANONYMOUS_ONLY = True

try:
    CACHE_MIDDLEWARE_KEY_PREFIX += '.' + path.basename(__file__).split('.')[0]
except NameError:
    from os import environ

    # Find out where this settings file is
    split_path = __file__.split(path.sep)
    # Calculate the path based on the location of this settings file
    django_project = split_path[-4]
    project_root = split_path[-5]

    CACHE_MIDDLEWARE_KEY_PREFIX = project_root + '.' +  django_project + '.' + \
                                  split_path[-1].split('.')[0]
