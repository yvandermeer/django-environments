"""
Sets some basic "sane defaults" for various Django settings.

Settings defined here include the ``ROOT_URLCONF``, ``STATIC_ROOT``,
``STATIC_URL`` and basic ``MIDDLEWARE_CLASSES``.
"""

from os import path

from .core import *


LOCAL_SERVER_PORT = 8001
"""
The HTTP port used when running the Django development server using the
:ref:`runserver <cmd_runserver>` command.
"""

ADMINS = (
    ('g0j0 admin', 'admin@g0j0.com'),
)
SERVER_EMAIL = ADMINS[0][1]
MANAGERS = ADMINS

DEFAULT_FROM_EMAIL = 'g0j0 admin <%s>' % ADMINS[0][1]

DEBUG = TEMPLATE_DEBUG = False

TIME_ZONE = 'Europe/Amsterdam'

LANGUAGE_CODE = 'en-us'

SITE_ID = 1

USE_I18N = False
USE_L10N = False

STATIC_ID = 'static'
STATIC_ROOT = path.join(PROJECT_ROOT, STATIC_ID)
STATIC_URL = '/%s/' % STATIC_ID

MEDIA_ID = 'media'
MEDIA_ROOT = path.join(PROJECT_ROOT, MEDIA_ID)
MEDIA_URL = '/%s/' % MEDIA_ID

STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
)

ROOT_URLCONF = DJANGO_PROJECT + '.urls'

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
)

SESSION_COOKIE_HTTPONLY = True

TEST_RUNNER = 'django.test.runner.DiscoverRunner'
