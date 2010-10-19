django-environments
===================

Manage different Django settings within a Django project, and easily
select settings from the command line or from WSGI. Different
settings can be helpful either on a single computer, but
django-environments is also intended for use on different system
environments, such as development, test, staging/acceptance and
production, all with "maximum DRY™".

On the command line, you specify your project and settings using
environment variables and (mostly) shell functions. When you run
your application via WSGI, a simple naming convention determines
which settings to use based on the name of the WSGI file. All this
helps to minimize the number of code changes and other file updates
when working across different environments.

Django-environments moves the ``settings.py`` to a settings package,
and suggests a settings inheritance model, which you can adhere to
as much as you like. Simply "inherit" from more generic settings
using ``from .. import *``, and overrule - see the provided examples.
If you'd rather use a "composition" model (import settings not just
from base settings "above", but also "from the side"), that's also
fine.

Getting Started
---------------

This release contains all the relevant shell scripts in the scripts
directory, and a fully working Django example project in ``mysite``.
You can copy files from it as needed to your own projects. To get
the example environment working, do the following:

1. Copy scripts/initenv_example to scripts/initenv.
2. Edit scripts/initenv, set ``PROJECT_ROOT`` and save the file.
3. Use ``source scripts/initenv`` to load django-environments into
   your shell. If you left in the djenv command, you will see the
   environment settings immediately.
4. For fun, you could do a ``cp -rpv mysite foo`` from the top
   directory, followed by ``djenv foo``. Be sure to try out the tab
   completion.
5. For automatic initialization of django-environments when using
   virtualenv with virtualenvwrapper, you can either
   ``source <path-to-project>/scripts/initenv`` from ``bin/postactivate``,
   or simply use your initenv's contents inside postactivate.
   Alternatively, you may also symlink ``bin/postactivate`` to your
   initenv script.

If everything works okay, the following shell functions are created:

* ``djenv``
                switch to different settings or another Django project.
* ``cdroot``
                go to current project root.
* ``cdjango``
                go to Django project root (one lower than project root).
* ``djadmin``
                shorthand for django-admin.py, which you should use
                instead of manage.py (unless you want to tweak things).
* ``runserver``
                perform ``django-admin.py runserver <port>``, using
                settings.LOCAL_SERVER_PORT if defined (see also
                scripts/create_apache_vhost_conf.sh).
* ``pipup``
                call ``pip install`` with the appropriate file listing
                the project's requirements.
* ``removeorphanpycs``
                remove .pyc files without a corresponding .py.
* ``pycompile``
                compile all .py files - handy for web server
                environments, calls ``removeorphanpycs`` afterwards.
* ``get_django_setting``
                get a value from the current settings
                module, useful for your own scripts (also
                see the experimental ``import_django_settings``).
* ``djexit``
                leave the current Django project.

See ``scripts/djenvlib`` for the more information.

Compatibility with virtualenv
-----------------------------

Please note django-environments does not in any way depend on
virtualenv, although it can be used together with virtualenv quite well.

When using django-environments within a single virtualenv environment,
you can switch between Django projects as often as you like. If
you use virtualenvwrapper, use ``bin/postactivate`` and
``bin/predeactivate`` for calling djenv and djexit respectively.

Compatibility with Python < 2.6
-------------------------------

In the example settings files, ``from .. import *`` is used. You will
need to change this to ``from <project>.settings import *`` for older
versions of Python. The downside is that you will have to include
the project name in your settings, which is a violation of the DRY
principle that django-environments tries to live by.

Using Apache mod_wsgi
---------------------

Should you wish to use the settings in for instance
``settings/env/staging.py``, simply copy the example
``mysite/deploy/development.wsgi`` to ``mysite/deploy/staging.wsgi``,
or make ``staging.wsgi`` a symlink (if your Apache configuration allows
it, which is normally the case). Next, add something like this to
your ``httpd.conf``::

    WSGIScriptAlias / /Users/spanky/repos/django-environments/mysite/deploy/staging.wsgi

And restart Apache. The identifier 'staging' in ``staging.wsgi`` will
automatically make sure ``settings.env.staging`` is used. Create other
.wsgi files for other environment settings.

Refer to the source of the provided WSGI script to see how specific
directories, like a virtualenv site-packages directory, can be
prepended to ``sys.path``, overruling standard Python environment settings.

Automatic generation of local WSGI links and settings file
----------------------------------------------------------

If you want your WSGI setup done as quickly as possible, activate an
environment - either directly via your ``scripts/initenv`` or through
virtualenv - and execute ``scripts/setup_local_wsgi.sh <environment>``, e.g.::

    $ scripts/setup_local_wsgi.sh staging

This will create a ``deploy/local.wsgi`` symbolic link to staging.wsgi and
will create a ``settings/env/local.py`` with default contents for a given
environment. Now, you only need to update ``settings.env.local`` with those
settings you want to keep absolutely local, like those containing
user ids and passwords. Keep in mind the script will overwrite exiting
``local.py`` settings files!

Directories
-----------

* The ``mysite/settings`` directory replaces ``settings.py`` and contains
  the default settings in ``generic.py``, whose contents are
  imported in ``__init__.py``.
* The ``mysite/settings/env`` directory contains the different settings
  files for every environment.
* All .wsgi files in the ``mysite/deploy`` folder are normally
  equal, except for the ``sys.path`` configuration. Their respective
  filenames are used to determine which settings to import. If
  your Apache configuration allows it, you could use symlinks
  instead of copies.
* The scripts directory contains the shell scripts intended to be
  sourced with the ``source`` command, unless they have a '.sh'
  extension.

Remarks
-------

* ``urls.py`` is just there to demonstrate the ``SERVE_MEDIA``
   setting, which is not essential anyway.
* ``manage.py`` is removed as the generated default ignores
  ``$DJANGO_SETTINGS_MODULE``, simply importing 'settings' instead.
* the Django ``startapp`` command will create new apps in
  ``$DJANGO_PROJECT/settings/env``. Apparently, Django uses the
  basename of the settings ``__file__`` as a reference point for
  the new app.