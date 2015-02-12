Inclusion in other projects
===========================

.. highlight:: sh

If you want to (temporarily) use a locally checked out version of |project| (as 
opposed to an official PyPI distribution) in other projects, you can do so 
easily using ``pip install -e`` (a.k.a. ``easy_install develop``).

.. note::

    The following example assumes you have succesfully completed a 
    :doc:`development install </installation/develop>` of |project| into 
    :file:`~/dev/django-environments`.

First, activate the *virtualenv* for your other project::

    $ workon some-other-project

Next, all you need to do is simply install |project| as an "editable" pip 
requirement::

    $ pip install -e ~/dev/django-environments

You should now be able to source the file containing the |project| shell functions::

    $ source djenvlib.sh
    $ type djenv | head -n 1
    djenv is a function

Also, the ``djenv`` package should now be available on the Python path::

    $ python -c "import djenv; print djenv.__version__"
    1.0 # or current version

.. note::

    Any changes to the Python code in your original |project| checkout should 
    now be directly reflected in your other project. Changes to any shell script
    however, require that you re-run ``pip install -e``.

For more information, see :doc:`/usage/index`.
