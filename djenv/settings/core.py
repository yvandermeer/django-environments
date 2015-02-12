"""
The only *required* settings to include in order to use django environments.

This module defines four basic settings which are specific to |project|:
"""
from os import environ, path


PROJECT_ROOT = environ['PROJECT_ROOT']
"""
The full path to the root directory of your Django project.

This is useful for defining other settings such as ``STATIC_ROOT``, and is used
by the :ref:`cdroot <cmd_cdroot>` command.
"""

PROJECT = path.basename(PROJECT_ROOT)
"""
The basename of the :attr:`PROJECT_ROOT`.
"""

DJANGO_PROJECT = environ['DJANGO_PROJECT']
"""
The basename of the directory containing your Django project's ``ROOT_URLCONF``
(``urls.py``).
"""

DJANGO_PROJECT_DIR = path.join(PROJECT_ROOT, DJANGO_PROJECT)
"""
The full path to the :attr:`DJANGO_PROJECT` directory.
"""
