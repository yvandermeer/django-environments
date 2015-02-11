WSGI deployment
===============

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
environment - either directly via your ``bin/initenv`` or through
virtualenv - and execute ``bin/setup_local_wsgi.sh <environment>``, e.g.::

    $ bin/setup_local_wsgi.sh staging

This will create a ``deploy/local.wsgi`` symbolic link to staging.wsgi and
will create a ``settings/env/local.py`` with default contents for a given
environment. Now, you only need to update ``settings.env.local`` with those
settings you want to keep absolutely local, like those containing
user ids and passwords. Keep in mind the script will overwrite existing
``local.py`` settings files!
