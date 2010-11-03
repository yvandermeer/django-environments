#!/bin/sh
#
# Standard environment wrapper for other scripts
#
# To be called from another script that sets the following correctly:
# - PROJECT_ROOT
# - DJANGO_PROJECT
# - DJANGO_SETTINGS
# - VIRTUAL_ENV (optional)

APP_HOME=`dirname $0` # Make sure we can refer back to this location

# Update PATH
PATH=$APP_HOME:$PATH

# Update PYTHONPATH
PYTHONPATH=$PROJECT_ROOT/apps:$PYTHONPATH

# Check for help request
if [ "$1" = "-h" -o "$1" = "--help" ]; then
    echo "Usage: `basename $0` <command> [args...]"
    echo
    echo "Where <command> is any of the following:"
    for file in $APP_HOME/*; do
        [ -x $file -a `basename $file` != `basename $0` ] && echo "    "`basename $file`
    done
    exit
fi

# Check if arguments supplied
[ -z "$1" ] && echo "Usage: `basename $0` <command> [args...]" 1>&2 && exit 1

# Check if command exists as an executable file
[ ! -x $APP_HOME/$1 ] && echo "`basename $0`: $1 not found!" && exit 1

# Set python environment
[ -f $VIRTUAL_ENV/bin/activate ] && source $VIRTUAL_ENV/bin/activate

# Set django environment
source $PROJECT_ROOT/bin/djenvlib

# Set DJANGO_PROJECT and DJANGO_SETTINGS to empty so djenv doesn't think
# we're already in an active environment (which it will try to exit first):
DJANGO_PROJECT= DJANGO_SETTINGS= djenv $DJANGO_PROJECT $DJANGO_SETTINGS

# Execute command
$*
