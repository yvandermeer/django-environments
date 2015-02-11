Credits & contributing
======================

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


Development setup
-----------------

To set up the project for local development::

    $ git clone https://github.com/yvandermeer/django-environments.git
    $ ...
    $ # TODO: provide further instructions


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
.. _github: https://github.com/yvandermeer/django-environments/
.. _gj: http://goeiejongens.nl/
.. _pypi: https://pypi.python.org/pypi/django-environments
.. _rtd: http://django-environments.readthedocs.org/
.. _vmh: http://vincenthillenbrink.nl/
.. _yvdm: http://yvandermeer.net/