Development install from Github
===============================

If you plan to make any changes to |project| or want to be able to run the
:doc:`example project </usage/exampleproject>`, you probably want to install and
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

From here, you can do a number of things:

* Run the :doc:`example project </usage/exampleproject>`.
* :doc:`Build the documentation locally</installation/docs>`.
* Use your checkout of |project| for 
  :doc:`inclusion in other projects </installation/otherprojects>` under development.
