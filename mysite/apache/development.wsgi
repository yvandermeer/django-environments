import os, site, sys
from generic import *

sys.path.insert(0, virtual_env_dir)
site.addsitedir(virtual_env_dir)

import django.core.handlers.wsgi

# Calculate the path based on the location of the WSGI script.
apache_configuration = os.path.dirname(__file__)
project = os.path.dirname(apache_configuration)
workspace = os.path.dirname(project)

sys.path.insert(0, workspace)
sys.path.insert(0, project)

os.environ['DJANGO_SETTINGS_MODULE'] = 'settings.env' + os.path.basename(__file__).split('.')[0]
application = django.core.handlers.wsgi.WSGIHandler()
