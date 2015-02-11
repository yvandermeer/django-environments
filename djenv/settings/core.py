"""
The only *required* settings to include in order to use django environments.

This module defines four basic settings which are specific to |project|:

* ``PROJECT_ROOT``
* ``PROJECT``
* ``DJANGO_PROJECT``
* ``DJANGO_PROJECT_DIR``

"""

from os import environ, path


PROJECT_ROOT = environ['PROJECT_ROOT']
PROJECT = path.basename(PROJECT_ROOT)
DJANGO_PROJECT = environ['DJANGO_PROJECT']
DJANGO_PROJECT_DIR = path.join(PROJECT_ROOT, DJANGO_PROJECT)
