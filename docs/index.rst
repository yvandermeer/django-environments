|project|
=========

|project| helps you manage different settings within a Django project, and
easily select those settings from the command line or from WSGI, all with
“maximum DRY™”.

On the command line, you specify your project and settings using environment
variables and (mostly) :doc:`shell functions <usage/commands>`. When you
:doc:`run your application via WSGI <usage/wsgi>`, a simple naming convention
determines which :doc:`settings <usage/settings>` to use based on the name of
the WSGI file. All this helps to minimize the number of code changes and other
file updates when working across different environments.

.. toctree::
   :maxdepth: 4

   requirements
   installation/index
   usage/index
   changes
   contributing
