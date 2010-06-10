from .. import *
from os.path import basename

CACHE_MIDDLEWARE_KEY_PREFIX = CACHE_MIDDLEWARE_KEY_PREFIX + '.' + basename(__file__).split('.')[0]
#CACHE_BACKEND = 'memcached://127.0.0.1:11211/'
#CACHE_MIDDLEWARE_SECONDS = 0
#CACHE_MIDDLEWARE_ANONYMOUS_ONLY = True

DATABASE_ENGINE = 'mysql'
DATABASE_HOST = ''
DATABASE_NAME = ''
DATABASE_USER = ''
DATABASE_PASSWORD = ''

DEBUG = False

SERVE_MEDIA = False

COMPRESS = True

SEND_BROKEN_LINK_EMAILS = False

ROSETTA_WSGI_AUTO_RELOAD = True
