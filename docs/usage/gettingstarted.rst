Getting started
===============

.. highlight:: sh

|project| is a very light-weight package that aims to make your life as Django 
developer easier. While it advocates certain patterns in setting up your Django 
project (e.g. an :ref:`"inheritance model" for your settings
<settings-organization>`), there are very few things that |project| enforces on 
you.

To demonstrate, here is a quick-start guide to getting a first-time Django project up 
and running together with |project|.

.. contents::
   :local:

Starting a basic Django project
-------------------------------

First, let's create a virtualenv with Django and |project| installed and 
initialize an empty Django project::

    $ mkvirtualenv djenv-example
    $ pip install Django # installs latest version of Django
    $ cd ~/dev/ && mkdir djenv-example # or wherever you like your project to live
    $ djadmin startproject example djenv-example

This should now give you something like this::

    djenv-example/
        example/
            __init__.py
            settings.py
            urls.py
            wsgi.py
        manage.py


Install |project|
-----------------
::

    $ pip install django-environments
    $ source djenvlib.sh
    $ type djenv | head -n 1
    djenv is a function # it works!


.. seealso::

    :doc:`/installation/index`


Enable |project| in your Django project
---------------------------------------

To enable |project| for your Django project, add one line to the top of your 
:file:`settings.py`:

.. code-block:: python
    :linenos:

    from djenv.settings.core import *
    # ...

.. note::

    This adds four custom settings that make further configuration easier. See 
    :mod:`djenv.settings.core` for details.

Use the |project| :ref:`setproject <cmd_setproject>` command to set 
the :attr:`~djenv.settings.core.PROJECT_ROOT`::

    $ setproject ~/dev/djenv-example/
    Warning: no django projects found
    $ echo $PROJECT_ROOT
    /Users/yuri/dev/djenv-example

.. note::

    The warning is because |project| expects a ``settings`` *package* (containing 
    an :file:`__init__.py`) instead of a single :file:`settings.py`. This is a 
    `known issue <https://github.com/yvandermeer/django-environments/issues/1>`_.

    See also :doc:`/usage/settings`.

Now use the :ref:`djenv <cmd_djenv>` command to tell |project| the name of our 
:attr:`~djenv.settings.core.DJANGO_PROJECT`, and it will respond with some useful 
environment information::

    $ djenv example
    Welcome to djenv-example/example. Environment info:
    PROJECT_ROOT: '/Users/yuri/dev/djenv-example'
    DJANGO_PROJECT: 'example'
    DJANGO_SETTINGS_MODULE: 'example.settings'
    PYTHONPATH: '/Users/yuri/dev/djenv-example:/Users/yuri/dev/djenv-example/lib:'

That is pretty much it! 


Useful commands
---------------

You can now use handy :doc:`commands </usage/commands>` to navigate within your
project, such as going to your Django project directory using 
:ref:`cdjango <cmd_cdjango>`::

    $ cdjango && pwd
    /Users/yuri/dev/djenv-example/example

or back to the project root using :ref:`cdroot <cmd_cdroot>`::

    $ cdroot && pwd
    /Users/yuri/dev/djenv-example

.. note::

    It may not surprise you that these commands were inspired by some of the very 
    `useful commands <http://virtualenvwrapper.readthedocs.org/en/latest/command_ref.html>`_ 
    that virtualenvrapper_ provides, such as ``cdvirtualenv`` and 
    ``cdsitepackages``.

If you quickly want know what the value of a Django setting is given the 
currently active django settings module, use the 
:ref:`getdjangosetting <cmd_getdjangosetting>` command::

    $ get_django_setting ROOT_URLCONF
    example.urls

.. seealso::

    A full list of :doc:`available commands </usage/commands>`


Next steps
----------

Now that you have the basics installed, you can further optimize and organize
your Django settings. For example, the default Django 1.7 :file:`settings.py` 
defines a ``BASE_DIR``:

.. code-block:: py

    # ...
    BASE_DIR = os.path.dirname(os.path.dirname(__file__))
    # ...

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        }
    }

But using |project|, you can simply use 
:attr:`~djenv.settings.core.PROJECT_ROOT`:

.. code-block:: py

    from djenv.settings.core import * # sets PROJECT_ROOT
    # ...

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': os.path.join(PROJECT_ROOT, 'db.sqlite3'),
        }
    }

In this particular case though, you could even use :mod:`djenv.settings.database`:

.. code-block:: py

    from djenv.settings.core import *
    from djenv.settings.database import * # defines DATABASES_DEFAULT
    # ...

    DATABASES['default'] = DATABASES_DEFAULT['sqlite']

You should also consider organizing your settings in a hierarchical structure -- 
see :doc:`/usage/settings`.

.. _virtualenvrapper: https://bitbucket.org/dhellmann/virtualenvwrapper/
