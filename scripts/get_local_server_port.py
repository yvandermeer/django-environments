#!/usr/bin/env python
from os import environ

settings = __import__(environ['DJANGO_SETTINGS_MODULE']).settings

try:
    print settings.LOCAL_SERVER_PORT
except AttributeError:
    print 8000
