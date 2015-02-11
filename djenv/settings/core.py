"""
The only required settings from django environments
"""

from os import environ, path


PROJECT_ROOT = environ['PROJECT_ROOT']
PROJECT = path.basename(PROJECT_ROOT)
DJANGO_PROJECT = environ['DJANGO_PROJECT']
DJANGO_PROJECT_DIR = path.join(PROJECT_ROOT, DJANGO_PROJECT)
