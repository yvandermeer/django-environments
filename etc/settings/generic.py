from os import environ, path


PROJECT_ROOT = environ['PROJECT_ROOT']
DJANGO_PROJECT = environ['DJANGO_PROJECT']
DJANGO_PROJECT_DIR = path.join(PROJECT_ROOT, DJANGO_PROJECT)

LOCAL_SERVER_PORT = 8001

ADMINS = (
    ('g0j0admin', 'admin@g0j0.com'),
)
SERVER_EMAIL = ADMINS[0][1]
MANAGERS = ADMINS

DEFAULT_FROM_EMAIL = 'Goeie Jongens <%s>' % ADMINS[0][1]

DEBUG = False
TEMPLATE_DEBUG = DEBUG

TIME_ZONE = 'Europe/Amsterdam'

LANGUAGE_CODE = 'en-us'

SITE_ID = 1

USE_I18N = False
USE_L10N = False

SERVE_DOCS = False
SERVE_MEDIA = False
MEDIA_ID = 'static'
MEDIA_ROOT = path.join(DJANGO_PROJECT_DIR, MEDIA_ID)
MEDIA_URL = '/%s/' % MEDIA_ID
ADMIN_MEDIA_PREFIX = '/adminmedia/'

ROOT_URLCONF = DJANGO_PROJECT + '.urls'

FIXTURE_DIRS = (
)

CACHE_BACKEND = 'dummy:///'
