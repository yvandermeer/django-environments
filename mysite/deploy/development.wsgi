# Copy this file to <environment>.wsgi to automatically use settings.env.<environment>
# Example Apache configuration:
# WSGIScriptAlias / /Users/spanky/repos/django-environments/mysite/deploy/local.wsgi

from os import path, environ
import site, sys

# Find out where this WSGI script is
wsgi_dir = path.dirname(__file__)
# Calculate the path based on the location of the WSGI script
DJANGO_PROJECT_DIR = path.dirname(wsgi_dir)
PROJECT_ROOT = path.dirname(DJANGO_PROJECT_DIR)

paths = (
    PROJECT_ROOT,
    '/var/virtualenvs/mysite/lib/python2.6/site-packages',
)

# Remember original sys.path
prev_sys_path = list(sys.path)

# Add each new directory
for directory in paths:
   site.addsitedir(directory)

# Reorder sys.path so new directories at the front
new_sys_path = []
for item in list(sys.path):
    if item not in prev_sys_path:
        new_sys_path.append(item)
        sys.path.remove(item)
sys.path[:0] = new_sys_path

# Now we can import from the environment
import django.core.handlers.wsgi

# Determine settings from filename
environ['DJANGO_SETTINGS_MODULE'] = path.basename(DJANGO_PROJECT_DIR) + \
    '.settings.env.' + path.basename(__file__).split('.')[0]
application = django.core.handlers.wsgi.WSGIHandler()

