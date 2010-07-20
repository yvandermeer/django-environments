from .. import *
from os.path import basename


try:
    CACHE_MIDDLEWARE_KEY_PREFIX += '.' + basename(__file__).split('.')[0]
except NameError:
    from os import environ
    CACHE_MIDDLEWARE_KEY_PREFIX = environ['DJANGO_PROJECT'] + '.' + \
                                  basename(__file__).split('.')[0]


DATABASE_ENGINE = 'sqlite3'
DATABASE_HOST = ''
DATABASE_NAME = '../db/local_sqlite.db'
DATABASE_USER = ''
DATABASE_PASSWORD = ''

DEBUG = True

SERVE_MEDIA = True

COMPRESS = False

SEND_BROKEN_LINK_EMAILS = False

ROSETTA_WSGI_AUTO_RELOAD = True
