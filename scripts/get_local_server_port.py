#!/usr/bin/env python
from os import environ

print __import__(environ['DJANGO_SETTINGS_MODULE'])
print __import__(environ['DJANGO_SETTINGS_MODULE']).settings

try:
    print __import__(environ['DJANGO_SETTINGS_MODULE']).settings.LOCAL_SERVER_PORT
except (ImportError, AttributeError):
    print 8000
