Migration from the version on Bitbucket
=======================================

Are you migrating from the version of |project| on Bitbucket_? You should be
able to get everything working with a few minor (but important) modifications.

.. contents::
   :local:

Remove |project| from "hg externals"
------------------------------------
Before, it was common to include |project| as an external Mercurial repository 
in your project using a ``requirements/externals-prd.txt`` file, which would
contain something like this::

    https://bitbucket.org/goeiejongens/django-environments#bed884e334c2

If you wish to migrate to this Github "fork", you have two options:

* :doc:`/installation/standard`
* :doc:`/installation/develop`


Reverse use of ``.sh`` for shell scripts
----------------------------------------
The use of the ``.sh`` extension for the shell scripts has been reversed: 
scripts that are meant to be directly executed now *do not* have an extension, 
and scripts that are meant to be "sourced" *do* have an ``.sh`` extension. If 
you call these scripts in any of your own scripts, you should update accordingly.


Top-level "etc" symlink no longer necessary
-------------------------------------------
Because |project| is now setuptools-compliant, it will install itself into the
Python "site-packages" directory (both if you do a  
:doc:`standard PyPI install </installation/standard>` or an 
:doc:`"editable" install from Github </installation/develop>`), and will 
therefore be automatically available on your Python path.

However, see next item.


Python "etc" package renamed to "djenv"
---------------------------------------
To avoid naming conflicts with other Python packages, ``djenv`` seemed like a 
better package name. You should probably do a global search/replace for:

* ``etc.settings`` => ``djenv.settings``
* ``etc.urls`` => ``djenv.urls``
