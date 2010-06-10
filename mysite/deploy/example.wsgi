# Copy this file to <environment>.wsgi to automatically use settings.env.<environment>
# Example Apache configuration:
# WSGIPythonHome /var/virtualenvs/development # Optional
# WSGIScriptAlias / /Users/spanky/repos/django-environments/mysite/deploy/local.wsgi

import os, site, sys
import django.core.handlers.wsgi

# Find out where this WSGI script is...
wsgi_dir = os.path.dirname(__file__)
# Calculate the path based on the location of the WSGI script
django_project = os.path.dirname(wsgi_dir)
project_root = os.path.dirname(django_project)

# Add paths
sys.path.insert(0, project_root)
sys.path.insert(0, django_project)

os.environ['DJANGO_SETTINGS_MODULE'] = 'settings.env.' + os.path.basename(__file__).split('.')[0]
application = django.core.handlers.wsgi.WSGIHandler()
