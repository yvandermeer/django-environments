Release notes
=============

dev
---
* Added :doc:`/usage/gettingstarted` section to documentation.
* Fixed some flake8_ errors/warnings

1.0a5
-----
* Fixed critical error where non-wheel installation from the PyPI package would 
  fail due to the "README.rst" not being included in the distribution package.

1.0a4
-----

* First release to PyPI_. See :doc:`/usage/bitbucketmigration`
* Renamed top-level ``etc`` package to ``djenv``
* Reversed use of ``.sh`` for shell scripts: executable scripts no longer have 
  the ``.sh`` extension, whereas shell scripts meant to be ``source``'d now *do* 
  have the extension
* Added Django 1.7 compatibility
* Moved "mysite" example project (and related files/directories) to top-level 
  "example" directory
* Expanded documentation, now implemented as Sphinx docs and published on `Read the Docs <rtd_>`_.


.. _flake8: http://flake8.readthedocs.org/
