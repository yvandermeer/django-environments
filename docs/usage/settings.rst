Settings management
===================

.. highlighting: python

It is often necessary for a Django project to have different settings depending
on the system environment, such as development, test, staging/acceptance and
production. However, even on a single computer it can be helpful to have an
easy way to switch between settings (e.g. to quickly simulate different 
environments).

|project| helps you manage different Django settings within a Django project,
and easily select settings from the command line or from WSGI, all with "maximum
DRY™".

.. contents::

Definining your settings
------------------------

Instead of using a single ``settings.py`` module, |project| expects you to 
organize your settings in a Python *package*, for example::

    mysite/
        settings/
            __init__.py
            env/
                __init__.py
                development.py
                production.py
            base.py

Additionally, it suggests (but does not dictate) you use an 
inheritance/generalization model, simply by "inheriting" from more generic
settings using ``from <package> import *``, and overruling the settings as needed::
    
    # mysite/settings/base.py
    from djenv.settings import *

    INSTALLED_APPS = (
        'django.contrib.auth',
        'django.contrib.contenttypes',
        'django.contrib.sessions',
        'django.contrib.sites',
        'django.contrib.messages',
        'mysite',
    )

    # mysite/settings/env/development.py
    from mysite.settings.base import *

    DEBUG = True

    INSTALLED_APPS += (
        'debug_toolbar',
    )


.. _available-settings:

Available settings modules
--------------------------

:mod:`djenv.settings.core`
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. automodule:: djenv.settings.core
   :members:

:mod:`djenv.settings.generic`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. automodule:: djenv.settings.generic
   :members:

:mod:`djenv.settings.database`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. automodule:: djenv.settings.database
   :members:

:mod:`djenv.settings.log`
~~~~~~~~~~~~~~~~~~~~~~~~~
.. automodule:: djenv.settings.log
   :members:

:mod:`djenv.settings.template`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. automodule:: djenv.settings.template
   :members:

:mod:`djenv.settings.cache`
~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. automodule:: djenv.settings.cache
   :members:
