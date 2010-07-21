# Copy this file to <environment>.wsgi to automatically use settings.env.<environment>
# Example Apache configuration:
# WSGIScriptAlias / /Users/spanky/repos/django-environments/mysite/deploy/local.wsgi

# These will be prepended to the front of sys.path, so great for
# virtual environments:
site_packages = (
    #'/var/virtualenvs/mysite/lib/python2.6/site-packages',
)

import os, site, sys
import site

# Remember original sys.path
prev_sys_path = list(sys.path) 

# Add each new site-packages directory
for directory in site_packages:
  site.addsitedir(directory)

# Reorder sys.path so new directories are at the front
new_sys_path = [] 
for item in list(sys.path): 
    if item not in prev_sys_path: 
        new_sys_path.append(item) 
        sys.path.remove(item) 
sys.path[:0] = new_sys_path 

# Now we can import from django
import django.core.handlers.wsgi

# Find out where this WSGI script is
wsgi_dir = os.path.dirname(__file__)
# Calculate the path based on the location of the WSGI script
django_project = os.path.dirname(wsgi_dir)
project_root = os.path.dirname(django_project)

# Add paths
sys.path.insert(0, project_root)
sys.path.insert(0, django_project)

os.environ['DJANGO_SETTINGS_MODULE'] = 'settings.env.' + \
    os.path.basename(__file__).split('.')[0]
application = django.core.handlers.wsgi.WSGIHandler()
