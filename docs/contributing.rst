Credits & contributing
======================

.. highlight:: sh

The |project| project was originally started by `Goeie Jongens <gj_>`_ and most
of its code was written by `Vincent Hillenbrink <vmh_>`_.

Minor contributions have been made by `Yuri van der Meer <yvdm_>`_, including 
its release to PyPI_.

.. note::

    |project| was originally created as a private Mercurial repository and later
    on it started being pushed to Bitbucket_ periodically. This version is meant 
    to be included into your project as an "external" Mercurial repository -- it 
    does not use Setuptools/distutils.

    In February 2015, it was migrated to Github_ (using 
    `git-remote-hg <git_remote_hg_>`_) and packaged using Setuptools for 
    distribution through PyPI_.

    The version as it exists on Github should be considered a fork of the 
    original version on Bitbucket.

If you want to contribute to |project|, feel free to 
`fork the project on Github <github_fork_>`_.

.. _dev-setup:

Development setup
-----------------

To set up the project for local development::

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


.. _bitbucket: http://bitbucket.org/goeiejongens/django-environments
.. _github_fork: https://github.com/yvandermeer/django-environments/fork
.. _git_remote_hg: https://github.com/fingolfin/git-remote-hg/
.. _gj: http://goeiejongens.nl/
.. _pypi: https://pypi.python.org/pypi/django-environments
.. _vmh: http://vincenthillenbrink.nl/
.. _yvdm: http://yvandermeer.net/
