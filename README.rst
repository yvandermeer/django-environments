django-environments
===================

django-environments helps you manage different settings within a Django project, 
and easily select those settings from the command line or from WSGI, all with
“maximum DRY™”.

On the command line, you specify your project and settings using environment
variables and (mostly) shell functions. When you run your application via WSGI,
a simple naming convention determines which settings to use based on the name of
the WSGI file. All this helps to minimize the number of code changes and other
file updates when working across different environments.

For more documentation, 
`Read the Docs <http://django-environments.readthedocs.org/>`_.
