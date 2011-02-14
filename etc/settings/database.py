from os import path, environ

from .generic import PROJECT_ROOT, DJANGO_PROJECT


DATABASES_DEFAULT = {
    'default_sqlite': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': path.join(PROJECT_ROOT, 'db', '%s.sqlite3' % DJANGO_PROJECT),
    },
    'default_mysql': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': DJANGO_PROJECT,
        'USER': 'gjsb',
    },
    'default_postgres': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': DJANGO_PROJECT,
        'USER': 'gjsb',
    }
}

DATABASES = {
    'default': DATABASES_DEFAULT['default_' + environ.get('DJANGO_DATABASE_TYPE', 'sqlite')]
}
