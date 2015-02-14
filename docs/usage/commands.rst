Available commands
==================

If everything works okay, the following shell functions are created:

.. _cmd_djp:

* ``djp`` (tab completion)
                Start working on a project (first argument, optional second
                argument is the Django project, default "www"), automatically 
                activating the virtualenv with the name of the project and 
                selecting ``settings.env.local`` using :ref:`djenv <cmd_djenv>`. 
                Virtualenv and empty project are created if they do not yet exist.

.. _cmd_setproject:

* ``setproject`` 
                Set the :attr:`~djenv.settings.core.PROJECT_ROOT` to either current or specified directory.

.. _cmd_djenv:

* ``djenv`` (tab completion)
                switch to different :doc:`settings </usage/settings>` or another Django project.

.. _cmd_cdroot:

* ``cdroot`` (tab completion)
                go to current :attr:`~djenv.settings.core.PROJECT_ROOT`.
* ``cdlib`` (tab completion)
                go to subdirectory 'lib' of the current 
                :attr:`~djenv.settings.core.PROJECT_ROOT`.

.. _cmd_cdjango:

* ``cdjango`` (tab completion)
                go to Django project root (one lower than project root).
* ``djadmin`` (install `tab completion <http://docs.djangoproject.com/en/dev/ref/django-admin/#bash-completion>`_ yourself)
                shorthand for django-admin.py, which you should use
                instead of manage.py (unless you want to tweak things).

.. _cmd_runserver:

* ``runserver``
                perform ``django-admin.py runserver <port>``, using
                :attr:`~djenv.settings.generic.LOCAL_SERVER_PORT` if defined. 
                Use option ``-p`` to  bind to your network IP address.
* ``djbrowse``
                points the browser to the server listening on
                :attr:`~djenv.settings.generic.LOCAL_SERVER_PORT` in the current
                settings.
* ``djvirtualbrowse``
                Points the browser to the named virtual host for the current
                settings. Assumes Apache is running as reverse proxy; see
                ``bin/create_apache_vhoste_conf`` for more information.
* ``pipup`` (tab completion)
                call ``pip install`` with the appropriate file listing
                the project's requirements.

.. _cmd_removeorphanpycs:

* ``removeorphanpycs``
                remove .pyc files without a corresponding .py.
* ``removeemptydirs``
                remove all empty directories in the project (calls
                :ref:`removeorphanpycs <cmd_removeorphanpycs>` first).
* ``pycompile``
                compile all .py files - handy for web server
                environments, calls 
                :ref:`removeorphanpycs <cmd_removeorphanpycs>` afterwards.
* ``get_django_setting``
                get a value from the current settings
                module, useful for your own scripts (also
                see the experimental ``import_django_settings``).
* ``djexit``
                leave the current Django project.

See ``bin/djenvlib.sh`` for the more information.
