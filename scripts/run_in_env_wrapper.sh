#
# Standard environment wrapper for other scripts
#
# To be called from another script that sets the following correctly:
# - VIRTUAL_ENV (optional)
# - PROJECT_ROOT
# - DJANGO_PROJECT
# - DJANGO_SETTINGS

APP_HOME=`dirname $0` # Make sure we can refer back to this location

# Update PATH
PATH=$APP_HOME:$PATH

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

# Set environment
[ -f $VIRTUAL_ENV/bin/activate ] && source $VIRTUAL_ENV/bin/activate
source $PROJECT_ROOT/scripts/initenv_generic $PROJECT_ROOT/apps
[ ! $? -eq 0 ] && exit 1

# Execute command
$*
