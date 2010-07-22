#!/usr/bin/env python
from os import environ
from sys import modules

try:
    settings = environ['DJANGO_SETTINGS_MODULE']
    __import__(settings)
    print modules[settings].LOCAL_SERVER_PORT
except (ImportError, AttributeError):
    print 8000
