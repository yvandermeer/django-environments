from .. import *  # noqa

from os import path


DEBUG = False

COMPRESS = True

SEND_BROKEN_LINK_EMAILS = False

ROSETTA_WSGI_AUTO_RELOAD = True


try:
    CACHE_MIDDLEWARE_KEY_PREFIX += '.' + path.basename(__file__).split('.')[0]
except NameError:
    # CACHE_MIDDLEWARE_KEY_PREFIX not defined in higher settings
    # Find out where this settings file is
    split_path = path.abspath(__file__).split(path.sep)
    # Calculate the path based on the location of this settings file
    django_project = split_path[-4]
    project = split_path[-5]

    CACHE_MIDDLEWARE_KEY_PREFIX = project + '.' + django_project + '.' + \
        split_path[-1].split('.')[0]

    # Clean up (we're in the settings)
    del split_path, django_project, project
