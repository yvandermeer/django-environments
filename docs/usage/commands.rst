Available commands
==================

If everything works okay, the following shell functions are created:

* ``djenv`` (tab completion)
                switch to different settings or another Django project.
* ``cdroot`` (tab completion)
                go to current project root.
* ``cdlib`` (tab completion)
                go to subdirectory 'lib' of the current project root.
* ``cdjango`` (tab completion)
                go to Django project root (one lower than project root).
* ``djadmin`` (install `tab completion <http://docs.djangoproject.com/en/dev/ref/django-admin/#bash-completion>`_ yourself)
                shorthand for django-admin.py, which you should use
                instead of manage.py (unless you want to tweak things).
* ``runserver``
                perform ``django-admin.py runserver <port>``, using
                settings.LOCAL_SERVER_PORT if defined. Use option
                ``-p`` to  bind to your network IP address.
* ``djbrowse``
                points the browser to the server listening on
                settings.LOCAL_SERVER_PORT in the current settings.
* ``djvirtualbrowse``
                Points the browser to the named virtual host for the current
                settings. Assumes Apache is running as reverse proxy; see
                ``bin/create_apache_vhoste_conf.sh`` for more information.
* ``pipup`` (tab completion)
                call ``pip install`` with the appropriate file listing
                the project's requirements.
* ``removeorphanpycs``
                remove .pyc files without a corresponding .py.
* ``removeemptydirs``
                remove all empty directories in the project (calls
                removeorphanpycs first).
* ``pycompile``
                compile all .py files - handy for web server
                environments, calls ``removeorphanpycs`` afterwards.
* ``get_django_setting``
                get a value from the current settings
                module, useful for your own scripts (also
                see the experimental ``import_django_settings``).
* ``djexit``
                leave the current Django project.

See ``bin/djenvlib`` for the more information.
