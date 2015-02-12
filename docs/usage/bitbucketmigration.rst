Migration from the version on Bitbucket
=======================================

.. highlight:: sh

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

g0j0 settings proxy removed
---------------------------
The :mod:`template settings <djenv.settings.template>` previously included the 
"g0j0.context_processors.settings_proxy" in the default list of 
``TEMPLATE_CONTEXT_PROCESSORS``. This ``g0j0`` dependency has now been removed
to keep |project| generic, so please add it manually in your project settings if you
require it.


About your global |project| installation
----------------------------------------
There's a good chance that you also have a global installation of |project| 
(e.g. to activate projects using the :ref:`djp <cmd_djp>` command). If so, you
probably currently source the Bash scripts containing the various
:doc:`shell functions </usage/commands>` from your ``.bashrc`` like so::

    source $REPOS/django-environments/bin/djenvlib
    source $REPOS/django-environments/bin/djenv.mercurial # optionally

If you want, you can simply keep working this way (replacing of course the 
checkout from Bitbucket with a :doc:`clone from Github </installation/develop>`.
Having a central checkout of |project| also allows you to 
:doc:`contribute </contributing>` to |project| itself 
:doc:`while using it in other projects </installation/otherprojects>`.

However, if you simply want to have a global installation of |project|, you 
could also simply install it from PyPI directly into your global site packages::

    $ deactivate # make sure you are not in any activated virtualenv
    $ PIP_REQUIRE_VIRTUALENV=false pip install django-environments

This installs the shell scripts into a common ``bin`` directory (the exact 
location depends on your Python installation)::

    $ which djenvlib.sh 
    /usr/local/bin/djenvlib.sh # Location for Homebrew Python on Mac OS X

You should then be able to simply source the scripts from your ``.bashrc`` 
like so::

    source djenvlib.sh
    source djenv.mercurial.sh
