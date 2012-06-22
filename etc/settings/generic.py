from os import environ, path


PROJECT_ROOT = environ['PROJECT_ROOT']
PROJECT = path.basename(PROJECT_ROOT)
DJANGO_PROJECT = environ['DJANGO_PROJECT']
DJANGO_PROJECT_DIR = path.join(PROJECT_ROOT, DJANGO_PROJECT)

LOCAL_SERVER_PORT = 8001

ADMINS = (
    ('g0j0 admin', 'admin@g0j0.com'),
)
SERVER_EMAIL = ADMINS[0][1]
MANAGERS = ADMINS

DEFAULT_FROM_EMAIL = 'g0j0 admin <%s>' % ADMINS[0][1]

DEBUG = False
TEMPLATE_DEBUG = DEBUG

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

FIXTURE_DIRS = (
)

CACHES = {
    'memcached': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '127.0.0.1:11211',
    },
    'database': {
        'BACKEND': 'django.core.cache.backends.db.DatabaseCache',
        'LOCATION': '_cache',
    },
    'dummy': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    }
}
CACHES['default'] = CACHES['database']

SESSION_COOKIE_HTTPONLY = True
