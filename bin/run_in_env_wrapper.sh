#!/usr/bin/env bash
#
# Standard environment wrapper for other scripts
#
# To be called from another script that sets the following correctly:
# - PROJECT_ROOT
# - DJANGO_PROJECT
# - DJANGO_SETTINGS
# - VIRTUAL_ENV (optional)

APP_HOME=$(cd `dirname $0`; pwd) # Make sure we can refer back to this location

# Update PATH
PATH=$APP_HOME:$PATH

# Update PYTHONPATH, add lib:
PYTHONPATH=$PROJECT_ROOT/lib:$PYTHONPATH

# Check for help request
if [ "$1" = "-h" -o "$1" = "--help" ]; then
    echo "Usage: `basename $0` <command> [args...]" 1>&2
    echo 1>&2
    echo "Where <command> is any of the following:" 1>&2
    for file in $APP_HOME/*; do
        [ -x $file -a `basename $file` != `basename $0` ] && echo "    "`basename $file` 1>&2
    done
    exit
fi

# Check if arguments supplied
[ -z "$1" ] && echo "Usage: `basename $0` <command> [args...]" 1>&2 && exit 1

# Set python environment
if [ ! -z $VIRTUAL_ENV ]; then
    if [ -f $VIRTUAL_ENV/bin/activate ]; then
        source $VIRTUAL_ENV/bin/activate
        if [ ! $? = 0 ]; then
            echo "Error activating virtualenv $VIRTUAL_ENV" 1>&2 && exit 1
        fi
    else
        echo "$VIRTUAL_ENV is not a valid virtualenv" 1>&2 && exit 1
    fi
fi

# Load django-environments
source $APP_HOME/djenvlib

# Set DJANGO_PROJECT and DJANGO_SETTINGS to empty so djenv doesn't think
# we're already in an active environment (which it will try to exit first):
DJANGO_PROJECT= DJANGO_SETTINGS= djenv $DJANGO_PROJECT $DJANGO_SETTINGS

# Execute command
$*
