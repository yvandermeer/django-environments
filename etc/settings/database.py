from os import path, environ

from .generic import PROJECT_ROOT, PROJECT, DJANGO_PROJECT


DATABASE_NAME = PROJECT

DATABASES_DEFAULT = {
    'default_sqlite': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': path.join(PROJECT_ROOT, 'db', '%s.sqlite3' % DJANGO_PROJECT),
    },
    'default_mysql': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': DATABASE_NAME,
        'USER': 'mysql',
    },
    'default_postgres': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': DATABASE_NAME,
        'USER': 'postgres',
    }
}

DATABASES = {
    'default': DATABASES_DEFAULT['default_' + \
                                 environ.get('DJANGO_DATABASE_TYPE', 'sqlite')]
}
