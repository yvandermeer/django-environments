#!/bin/sh
#
# Generates Apache virtual host configuration for reverse proxying
# runserver instances.
#
# Experimental.
#
# To be run in an activated django-environment environment, i.e.
# $PROJECT_ROOT must be set correctly.

domain=local
[ ! -z "$DOMAIN" ] && domain=$DOMAIN

# The root of the project should exist, of course
[ -z "$PROJECT_ROOT" ] && \
    echo "Variable PROJECT_ROOT not set or empty" 2>&1 && exit 1
[ ! -d "$PROJECT_ROOT" ] && \
     echo "Variable PROJECT_ROOT does not point to a readable directory" 2>&1 && exit 1

cd `dirname $0`

for django_project_dir in $PROJECT_ROOT/*; do
    if [ -f $django_project_dir/settings.py -o -d $django_project_dir/settings ]; then
        django_project=`basename $django_project_dir`
        export PYTHONPATH=$django_project_dir
        export DJANGO_SETTINGS_MODULE=settings
        port=`./get_local_server_port.py`

cat << EOF
<VirtualHost 127.0.0.1:*>
    RewriteEngine On
    ServerName $django_project.$domain
    RewriteRule ^/(.*) http://localhost:$port/\$1 [P]
</VirtualHost>
EOF
        
    fi
done
