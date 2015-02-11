Installation
============

.. seealso::
    :doc:`requirements`


Regular install
---------------

Installing |project| into your existing Django project as a "regular" Python 
package is easy::

    $ pip install django-environments

This installs two things:

1. A ``djenv`` Python package containing some default :ref:`settings modules <available-settings>` you can
   "extend" from.
2. A set of :doc:`Bash scripts and Shell functions <usage/commands>` for easily switching between Django settings and 
   projects.

For more information on using |project|, see :doc:`usage/index`.


.. _dev-setup:

Development install
-------------------

If you plan to make any changes to |project| or want to be able to run the
:doc:`example project <usage/exampleproject>`, you probably want to install and
set up the project for local development::

    $ cd ~/dev # or wherever
    $ git clone https://github.com/yvandermeer/django-environments.git
    $ cd django-environments
    $ mkvirtualenv django-environments
    $ pip install -r requirements/libs-dev.txt

This installs the bare requirements for local development and deploys |project| 
itself using "easy_install develop".

.. note::
    
    The above example assumes you use virtualenvwrapper installed. To use plain
    ``virtualenv``::

        $ virtualenv ~/.virtualenvs/django-environments
        $ source ~/.virtualenvs/django-environments/bin/activate

From here, you can do two things:

#. Run the :doc:`example project <usage/exampleproject>`
#. Use your checkout of |project| in other local projects under development


Building the documentation
--------------------------

Documention is provided in Sphinx format in the ``docs`` subdirectory. To
build the HTML version of the documentation yourself::

    $ cd docs
    $ make html

Alternatively, you can browse the documentation on `Read the Docs <rtd_>`_.
