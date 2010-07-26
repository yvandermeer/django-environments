#!/bin/sh
#
# Generates deploy/local.wsgi settings/env/local.py for a given environment
#
# To be run in an activated django-environment environment, i.e.
# $PROJECT_ROOT and $DJANGO_PROJECT must be set correctly.

env=$1
local=local # Identifier for local configuration

# Check arguments
[ -z "$env" ] && echo "Usage: $0 <environment>" 1>&2 && exit 1

# The root of the project should exist, of course
[ -z "$PROJECT_ROOT" ] && \
    echo "Variable PROJECT_ROOT not set or empty" 1>&2 && exit 1
[ ! -d "$PROJECT_ROOT" ] && \
     echo "Variable PROJECT_ROOT does not point to a readable directory" 1>&2 && exit 1

# Check Django project as well
[ -z "$DJANGO_PROJECT" ] && \
    echo "Variable DJANGO_PROJECT not set or empty" 1>&2 && exit 1
[ ! -d "$PROJECT_ROOT/$DJANGO_PROJECT" ] && \
    echo "Variable DJANGO_PROJECT does not identify a readable directory within $PROJECT_ROOT" 1>&2 && \
    exit 1

# WSGI symlink

deploy_dir=$PROJECT_ROOT/$DJANGO_PROJECT/deploy
wsgi_target=$deploy_dir/$env.wsgi
wsgi_local=$deploy_dir/$local.wsgi
[ ! -f "$wsgi_target" ] && echo "$wsgi_target not found - exiting" 1>&2 && exit 1

rm -f $wsgi_local
ln -s $env.wsgi $wsgi_local
[ ! $? -eq 0 ] && echo "Error creating symlink $wsgi_local" 1>&2 && exit 1
echo "Link $local.wsgi to $wsgi_target created" 1>&2

# Settings python file

settings_dir=$PROJECT_ROOT/$DJANGO_PROJECT/settings/env
settings_target=$settings_dir/$env.py
settings_local=$PROJECT_ROOT/$DJANGO_PROJECT/settings/env/$local.py
[ ! -f "$settings_target" ] && echo "$settings_target not found - exiting" 1>&2 && exit 1

cat > $settings_local << EOF
from $env import *

# You can set stuff you don't wish to store anywhere else here, like:
# DATABASES['default']['PASSWORD'] = 'secret'
EOF
echo "$settings_local created" 1>&2
