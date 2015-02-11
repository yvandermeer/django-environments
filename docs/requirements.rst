Requirements
============

|project| should run on any modern version of Python (v2.6 and up) and Django. 
It was tested to be compatible with Django 1.7, but should run on older 
versions as well.

.. note::

    As |project| make heavy use of Unix Shell scripts, it will only run on Unix-
    variants (Linux/Mac OS X). Windows support is currently not in scope.

Compatibility with virtualenv
-----------------------------

Please note |project| does not in any way depend on
virtualenv, although it can be used together with virtualenv quite well.

When using |project| within a single virtualenv environment,
you can switch between Django projects as often as you like. If
you use virtualenvwrapper, use ``bin/postactivate`` and
``bin/predeactivate`` for calling djenv and djexit respectively.

Compatibility with Python < 2.6
-------------------------------

In the example settings files, ``from .. import *`` is used. You will
need to change this to ``from <project>.settings import *`` for older
versions of Python. The downside is that you will have to include
the project name in your settings, which is a violation of the DRY
principle that |project| tries to live by.
