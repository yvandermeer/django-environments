from .. import *
from os.path import basename

CACHE_MIDDLEWARE_KEY_PREFIX = CACHE_MIDDLEWARE_KEY_PREFIX + '.' + basename(__file__).split('.')[0]

DATABASE_ENGINE = 'postgresql'
DATABASE_HOST = ''
DATABASE_NAME = ''
DATABASE_USER = ''
DATABASE_PASSWORD = ''

DEBUG = True

SERVE_MEDIA = True

COMPRESS = False

SEND_BROKEN_LINK_EMAILS = False

ROSETTA_WSGI_AUTO_RELOAD = True
