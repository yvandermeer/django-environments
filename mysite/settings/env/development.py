from .. import *


DEBUG = True

SERVE_MEDIA = True

INSTALLED_APPS += (
    'django.contrib.databrowse',
    #'debug_toolbar',
    #'devserver',
    #'django_extensions',
)

COMPRESS = False

SEND_BROKEN_LINK_EMAILS = False

ROSETTA_WSGI_AUTO_RELOAD = True
