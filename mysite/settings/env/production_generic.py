from .. import *
from os.path import basename


try:
    CACHE_MIDDLEWARE_KEY_PREFIX += '.' + basename(__file__).split('.')[0]
except NameError:
    from os import environ
    CACHE_MIDDLEWARE_KEY_PREFIX = environ['DJANGO_PROJECT'] + '.' + \
                                  basename(__file__).split('.')[0]
CACHE_BACKEND = 'memcached://127.0.0.1:11211/'
CACHE_MIDDLEWARE_SECONDS = 86400
CACHE_MIDDLEWARE_ANONYMOUS_ONLY = True

DATABASE_ENGINE = 'postgresql'
DATABASE_HOST = ''
DATABASE_NAME = ''
DATABASE_USER = ''
DATABASE_PASSWORD = ''

DEBUG = False

SERVE_MEDIA = False

COMPRESS = True

SEND_BROKEN_LINK_EMAILS = True

ROSETTA_WSGI_AUTO_RELOAD = False

GOOGLE_ANALYTICS_CODE = 'UA-XXX'
