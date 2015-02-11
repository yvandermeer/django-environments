Running the example project
===========================

.. highlight:: sh

To demonstrate (and test) |project|, it comes with an example Django project, 
located in the top-level ``example`` directory in the source code.

.. note:: 

    When :doc:`installing <installation>` |project| from PyPI, only the bare 
    essentials are installed. To run you the example project, follow the 
    instructions for a :ref:`local development setup <dev-setup>`.

    Everything below assumes you already have a local checkout from the Github_
    repository.


To run the example project, you can use the ``example/bin/initenv.sh`` example 
script::

    $ workon django-environments
    $ source ~/Development/Projects/django-environments/example/bin/initenv.sh
    $ runserver

To make it even easier, you may want to hook into virtualenvwrapper's `postactivate` hook::

    $ echo 'source ~/dev/django-environments/example/bin/initenv.sh' >> $WORKON_HOME/django-environments/bin/postactivate
    $ workon django-environments
    $ runserver

For more details on, see the contents of the :file:`example/bin/initenv.sh` file.

.. warning::

    Alternatively, instead of sourcing the example ``initenv.sh`` script from 
    the ``postactivate`` script, you might be tempted to symlink the file. 
    This won't work however, as it breaks the current ``PROJECT_ROOT`` detection 
    in the example ``initenv.sh`` script::

        PROJECT_ROOT=$(cd -P "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)
