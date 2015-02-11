About |project|
===============

Manage different Django settings within a Django project, and easily
select settings from the command line or from WSGI. Different
settings can be helpful either on a single computer, but
|project| is also intended for use on different system
environments, such as development, test, staging/acceptance and
production, all with "maximum DRY™".

On the command line, you specify your project and settings using
environment variables and (mostly) shell functions. When you run
your application via WSGI, a simple naming convention determines
which settings to use based on the name of the WSGI file. All this
helps to minimize the number of code changes and other file updates
when working across different environments.

|project| moves the ``settings.py`` to a settings package,
and suggests a settings inheritance model, which you can adhere to
as much as you like. Simply "inherit" from more generic settings
using ``from .. import *``, and overrule - see the provided examples.
If you'd rather use a "composition" model (import settings not just
from base settings "above", but also "from the side"), that's also
fine.

Getting Started
---------------

This release contains all the relevant shell scripts in the bin
directory, and a fully working Django example project in ``mysite``.
You can copy files from it as needed to your own projects. To get
the example environment working, do the following:

1. Copy bin/initenv_example to bin/initenv.
2. Edit bin/initenv, set ``PROJECT_ROOT`` and save the file.
3. Use ``source bin/initenv`` to load |project| into
   your shell. If you left in the djenv command, you will see the
   environment settings immediately.
4. For fun, you could do a ``cp -rpv mysite foo`` from the top
   directory, followed by ``djenv foo``. Be sure to try out the tab
   completion.
5. For automatic initialization of |project| when using
   virtualenv with virtualenvwrapper, you can either
   ``source <path-to-project>/bin/initenv`` from ``bin/postactivate``,
   or simply use your initenv's contents inside postactivate.
   Alternatively, you may also symlink ``bin/postactivate`` to your
   initenv script.




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
* The bin directory contains the shell scripts intended to be
  sourced with the ``source`` command, unless they have a '.sh'
  extension.
