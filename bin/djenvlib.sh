#
# django-environments initialization script
#
# Source this file, then use the "djp" command, or use "setproject"
# and "djenv" manually.
#

DJENV_HOME=$(cd -P "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)
DEFAULT_ROOT=/deploy
DEFAULT_REPOS=$DEFAULT_ROOT/repos

# Not to be called directly, see djenv below
function _djenv_init() {
    DJANGO_PROJECT=$1
    DJANGO_SETTINGS=$2

    # The root of the project should exist, of course
    [ -z "$PROJECT_ROOT" ] && \
        echo "Variable \$PROJECT_ROOT not set or empty" 1>&2 && return 1
    [ ! -d "$PROJECT_ROOT" ] && \
         echo "Variable \$PROJECT_ROOT '$PROJECT_ROOT'" \
            "does not point to a readable directory" 1>&2 && return 1

    # Check Django project as well
    [ -z "$DJANGO_PROJECT" ] && \
        echo "Argument \$DJANGO_PROJECT not set or empty" 1>&2 && return 1
    [ ! -d "$PROJECT_ROOT/$DJANGO_PROJECT" ] && \
        echo "Argument \$DJANGO_PROJECT '$DJANGO_PROJECT'" \
            "does not identify a readable directory within $PROJECT_ROOT" 1>&2 && \
        return 1

    # If no particular settings are defined, just use the "base" settings
    _OLD_DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
    if [ ! -z "$DJANGO_SETTINGS" ]; then
        DJANGO_SETTINGS_MODULE=$DJANGO_PROJECT.$DJANGO_SETTINGS
    else
        DJANGO_SETTINGS_MODULE=$DJANGO_PROJECT.settings
    fi

    # Set the PYTHONPATH to include PROJECT_ROOT
    _OLD_PYTHONPATH=$PYTHONPATH
    PYTHONPATH=$PROJECT_ROOT:$PROJECT_ROOT/lib:$PYTHONPATH

    export PROJECT_ROOT DJANGO_PROJECT PYTHONPATH DJANGO_SETTINGS_MODULE

    # Test settings import
    python -c "import $DJANGO_SETTINGS_MODULE" > /dev/null 2>&1
    if [ ! "$?" -eq 0 ]; then
        echo "Error importing settings $DJANGO_SETTINGS_MODULE" \
            "(PYTHONPATH: $PYTHONPATH)" 1>&2
        python -c "import $DJANGO_SETTINGS_MODULE"
        return 1
    fi

    # Test if the definitions in the settings match ours
    if [ ! -z "`get_django_setting :`" ]; then
        echo "Current Django settings generate output - debugging print statements maybe?" 1>&2
    else
        [ "$PROJECT_ROOT" != "`get_django_setting PROJECT_ROOT`" ] && \
            echo "\$PROJECT_ROOT in Django settings is different from shell" 1>&2 && \
            echo "\$PROJECT_ROOT: $PROJECT_ROOT" 1>&2 && \
            echo "settings.PROJECT_ROOT: `get_django_setting PROJECT_ROOT`" 1>&2 && \
            return 1
        [ "$DJANGO_PROJECT" != "`get_django_setting DJANGO_PROJECT`" ] && \
            echo "\$DJANGO_PROJECT in Django settings is different from shell" 1>&2 && \
            return 1
        [ "$PROJECT_ROOT/$DJANGO_PROJECT" != "`get_django_setting DJANGO_PROJECT_DIR`" ] && \
            echo "\$DJANGO_PROJECT_DIR in Django settings is different from" \
                "\$PROJECT_ROOT/\$DJANGO_PROJECT" 1>&2 && \
            return 1
    fi

    # We're good - let's set the prompt
    _OLD_DJENV_PS1=$PS1
    PS1=[$DJANGO_PROJECT]$PS1

    # Show environment info
    if [ "$SHOW_DJANGO_ENVIRONMENT" = "yes" ]; then
        echo "Welcome to `basename $PROJECT_ROOT`/$DJANGO_PROJECT. Environment info:"
        djenv
    fi

    # Check non-critical settings
    local dirs dir
    for dirs in TEMPLATE_DIRS FIXTURE_DIRS; do
        eval `import_django_settings $dirs`
        envname=DJANGO_$dirs
        for dir in ${!envname}; do
            [ ! -d $dir ] && \
                echo "Warning: \"$dir\" in settings.$dirs is not a valid directory" 1>&2
        done
    done

    return 0
}

# Register cleanup hook.
function _djenv_register_cleanup() {
    local func
    for func in $*; do
        if [ -z "$DJENV_CLEANUP_FUNCTIONS" ]; then
            DJENV_CLEANUP_FUNCTIONS=$func
        else
            DJENV_CLEANUP_FUNCTIONS=$DJENV_CLEANUP_FUNCTIONS:$func
        fi
    done
}

# Verification functions

# Check if $PROJECT_ROOT is set.
function _verify_project_root() {
    [ -z "$PROJECT_ROOT" ] && echo "No \$PROJECT_ROOT" 1>&2 && return 1
    return 0
}

# Check if $DJANGO_PROJECT is set.
function _verify_django_project() {
    [ -z "$DJANGO_PROJECT" ] && echo "No \$DJANGO_PROJECT" 1>&2 && return 1
    return 0
}

# Check if both $PROJECT_ROOT and $DJANGO_PROJECT are set.
function _verify_project_root_and_django_project() {
    _verify_project_root || return 1
    _verify_django_project || return 1
    return 0
}

# Check if $DJANGO_SETTINGS_MODULE is set.
function _verify_django_settings_module() {
    [ -z "$DJANGO_SETTINGS_MODULE" ] && \
        echo "No \$DJANGO_SETTINGS_MODULE" 1>&2 && return 1
    return 0
}

# Some useful functions

# Exit current project.
function djexit() {
    [ -z "$DJANGO_PROJECT" ] && return 1

    # Restore prompt
    if [ ! -z "$_OLD_DJENV_PS1" ]; then
        PS1=$_OLD_DJENV_PS1
        unset _OLD_DJENV_PS1
    fi

    # Restore django settings
    if [ ! -z "$_OLD_DJANGO_SETTINGS_MODULE" ]; then
        DJANGO_SETTINGS_MODULE=$_OLD_DJANGO_SETTINGS_MODULE
    else
        unset DJANGO_SETTINGS_MODULE
    fi

    # Restore python path
    if [ ! -z "$_OLD_PYTHONPATH" ]; then
        PYTHONPATH=$_OLD_PYTHONPATH
    else
        unset PYTHONPATH
    fi

    # Call the registerd cleanup functions
    _IFS=$IFS
    IFS=:
    local func
    for func in $DJENV_CLEANUP_FUNCTIONS; do
        $func
    done
    IFS=$_IFS
}

# Change django project.
# Example:
# djenv # Print current environment settings
# or
# djenv www # Use default settings
# or
# djenv www settings.env.local # Use specific settins
function djenv() {
    # Environment info
    if [ -z "$1" ]; then
        echo "PROJECT_ROOT: '$PROJECT_ROOT'"
        echo "DJANGO_PROJECT: '$DJANGO_PROJECT'"
        echo "DJANGO_SETTINGS_MODULE: '$DJANGO_SETTINGS_MODULE'"
        echo "PYTHONPATH: '$PYTHONPATH'"
        return
    fi

    # Help
    if [ "$1" = "-h" -o "$1" = "--help" ]; then
        echo "Usage: djenv [Django project [Django settings]]"
        return
    fi

    # Check $PROJECT_ROOT
    if [ -z "$PROJECT_ROOT" ]; then
        echo "Variable \$PROJECT_ROOT not set or empty" 1>&2
        return 1
    fi

    # Exit current environment (if any)
    djexit

    # Initialize
    _djenv_init $*

    # On error, use djexit for cleanup
    [ ! $? -eq 0 ] && djexit && return 1

    # Change working directory
    cdroot

    return 0
}

# Get a django setting from the current or specified settings module.
#
# Example:
# get_django_setting LANGUAGE_CODE
#
# Returns the second argument if setting cannot be found. The third
# argument is an alternative settings configuration, for example:
# get_django_setting DEBUG 'False' www.settings.env.prd
#
# Be aware that the settings file should not print anything to
# stdout for this to work!
function get_django_setting() {
    _verify_project_root || return 1
    [ -z "$1" ] && \
        echo "Usage: get_django_setting <setting-name>" \
            "[default-value] [settings-module]" 1>&2 && \
        return 1

    local settings_module
    if [ ! -z "$3" ]; then
        settings_module=$3
    else
        _verify_django_settings_module || return 1
        settings_module=$DJANGO_SETTINGS_MODULE
    fi

    DJANGO_SETTINGS_MODULE=$settings_module python << EOF
from django.conf import settings
print getattr(settings, '`echo $1 | tr 'a-z' 'A-Z'`', '$2')
EOF
}

# Import django settings into the shell environment.
#
# When using, set $IFS to empty (this is needed because we eval
# the output of the python-generated shell script code):
# IFS=''
#
# Then use the function as follows:
# eval `import_django_settings` # all settings
# or
# eval `import_django_settings ADMIN` # all settings starting with 'ADMIN'
#
# Tuples and lists items are separated with newlines, so set $IFS
# to newline to get to those:
# IFS='
# '
# Note that all variables are prefixed with 'DJANGO_'.
function import_django_settings() {
    _verify_project_root || return 1
    _verify_django_settings_module || return 1

    prefix=DJANGO_
    python << EOF
from django.conf import settings
from types import TupleType, ListType, DictType

def escape(value):
    return str(value).replace('"', '\\\\"')

prefix = '$1'.upper()
for name in sorted(dir(settings)):
    if name.isupper() and name.find('__') == -1 and name.find(prefix) == 0:
        value = getattr(settings, name)
        if type(value) in (TupleType, ListType):
            print '$prefix%s="' % name
            for item in value:
                print escape(item)
            print '"'
        elif type(value) == DictType:
            print '$prefix%s="' % name
            for name, value in value.items():
                print '%s:%s' % (name, escape(value))
            print '"'
        else:
            print '$prefix%s="%s"' % (name, escape(value))
EOF
}

# Set the project root to either current or specified directory.
setproject() {
    if [ ! -z "$1" ]; then
        cd $1
        [ ! $? -eq 0 ] && return 1
    fi
    djexit
    export PROJECT_ROOT=`pwd`

    local projects=`show_django_projects`
    if [ ! -z "$projects" ]; then
        echo "Available Django projects (use the djenv command to select):" 1>&2
        echo $projects 1>&2
    else
        echo "Warning: no django projects found" 1>&2
    fi
}

# Change directory to project root.
function cdroot() {
    _verify_project_root || return 1

    cd $PROJECT_ROOT/$1
}

# Change directory to project lib directory.
function cdlib() {
    _verify_project_root || return 1

    cd $PROJECT_ROOT/lib/$1
}

# Install dependencies for a given environment (first argument);
# the file with the dependencies should be in the requirements
# directory and its name should have the format 'libs-<environment>.txt'
function pipup() {
    _verify_project_root || return 1
    [ -z "$1" ] && \
        echo "Usage: pipup <requirements-identifier> [pip options]" 1>&2 && \
        return 1

    local requirements=$1
    shift
    pip install --requirement=$PROJECT_ROOT/requirements/libs-$requirements.txt $*
}

function _externals() {
    while true; do
        read source destination

        if [ -z "$source" ]; then
            return
        fi
        revision=`echo $source | sed -E -n 's/([^#]*)#(.*)/\2/p'`
        source=`echo $source | cut -f1 -d#`
        if [ -z "$destination" ]; then
            destination=`basename $source`
        fi
        if [ -L "$destination" ]; then
            echo "Not updating symbolic link $destination"
            return
        fi
        if [ ! -d $destination ]; then
            hg clone --noupdate $source $destination
        else
            hg pull --repository $destination
        fi
        hg up --repository $destination $revision
    done
}

# Install or update dependencies in the externals directory for a given
# environment (first argument); the file with the dependencies should be
# in the requirements directory and its name should have the format
# 'externals-<environment>.txt', containing lines with the following format:
# repo-location[#revision] [destination]
# For instance:
# ../../lib-core
# ../../lib-tools#44 tools
# http://user@host/hg/lib-tools#44
#
# Relative paths are evaluated from the externals directory. Only
# Mercurial is supported.
function externalsup() {
    _verify_project_root || return 1
    [ -z "$1" ] && \
        echo "Usage: externalsup <requirements-identifier>" 1>&2 && \
        return 1

    local requirements=$1
    local requirements_file=$PROJECT_ROOT/requirements/externals-$requirements.txt
    [ ! -f "$requirements_file" ] && \
        echo "Requirements file $requirements_file not found" 1>&2 && \
        return 1

    (
        if [ ! -d $PROJECT_ROOT/externals ]; then
            mkdir $PROJECT_ROOT/externals
        fi
        cd $PROJECT_ROOT/externals
        grep -v '^#' $requirements_file | _externals
    )
}

# Use compileall to compile all .py files - handy for web server
# environments where the server user often has no write access to the
# .pyc files / directories.
function pycompile() {
    _verify_project_root || return 1

    python -c "import compileall; compileall.compile_dir('$PROJECT_ROOT')"
    removeorphanpycs
}

# Remove .pyc files without a corresponding .py the fast way.
function removeorphanpycs() {
    _verify_project_root || return 1

    # Use the GNU extension --no-run-if-empty on Linux, in case no files are found
    if [ `uname` = Linux ]; then
        local extra_xargs_args=--no-run-if-empty
    fi

    # Pipe through bash because this implementation uses process substitution,
    # and you don't want to export functions using that since /bin/sh will choke
    # on them with a syntax error because process substitution is not available in
    # POSIX mode
    echo "diff --old-line-format= --new-line-format=%L --unchanged-group-format= \
        <(find -H $PROJECT_ROOT -name \*.py | sort) \
        <(find -H $PROJECT_ROOT -name \*.pyc | sed 's/c$//' | sort) | \
        sed 's/$/c/' | xargs $extra_xargs_args rm -v" | bash
}

# Remove all directories in the project that contain only the specified file.
# Experimental.
function cleanupdirs() {
    [ -z "$1" ] && echo "Usage: cleanupdirs <filename>" 1>&2 && return 1

    local file=$1

    # Use the GNU extension --no-run-if-empty on Linux, in case no files are found
    if [ `uname` = Linux ]; then
        local extra_xargs_args=--no-run-if-empty
    fi

    for dir in `find $PROJECT_ROOT -type f -name $file | \
                xargs -n 1 $extra_xargs_args dirname`; do
        if [ `ls -a $dir | grep -v $file | wc -l` = 2 ]; then
            rm $dir/$file
            rmdir $dir
        fi
    done
}

# Remove all empty directories in the project.
function removeemptydirs() {
    _verify_project_root || return 1

    # Make directories as empty as possible
    removeorphanpycs
    cleanupdirs .DS_Store
    # Then remove the totally empty ones, depth first
    find $PROJECT_ROOT -depth -type d -empty -delete
}

# Change directory to Django project.
function cdjango () {
    _verify_project_root_and_django_project || return 1

    cd $PROJECT_ROOT/$DJANGO_PROJECT/$1
}

# Forget manage.py, django-admin.py respects our settings!
function djadmin() {
    django-admin.py $*
}

# Get network IP address.
function get_network_ip() {
    python << EOF
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(('google.com', 80))
print s.getsockname()[0]
EOF
}

# Run development server on settings.LOCAL_SERVER_PORT, and restart
# automatically. With -p as first argument, the server listens to
# the network IP address as well as localhost.
function runserver() {
    _verify_project_root_and_django_project || return 1

    if [ "$1" = -p ]; then
        local ip=0.0.0.0:
        shift
    fi
    local port=`get_django_setting LOCAL_SERVER_PORT 8000`

    while true; do
        djadmin runserver --nothreading $ip$port $*
        if [ $? -ne 1 ]; then
            return 1
        fi
        sleep 0.5
    done
}

# Run test server on settings.LOCAL_SERVER_PORT, and restart automatically.
function testserver() {
    _verify_project_root_and_django_project || return 1

    local port=`get_django_setting LOCAL_SERVER_PORT 8000`
    djadmin testserver --addrport=$port $*
}

# Open an URL in the default browser.
function open_url() {
    if which xdg-open > /dev/null; then
        # Linux
        xdg-open "$@"
    else
        # Mac OS
        open "$@"
    fi
}

# Points the browser to the server running the current settings:
# http://localhost:<settings.LOCAL_SERVER_PORT>/$1
# With -p as first argument, use the public network IP address
# instead of localhost (for access a server running with
# runserver -p).
function djbrowse() {
    _verify_project_root_and_django_project || return 1
    _verify_django_settings_module || return 1

    if [ "$1" = -p ]; then
        local ip=`get_network_ip`
        shift
    else
        local ip=localhost
    fi
    local port=`get_django_setting LOCAL_SERVER_PORT 8000`
    open_url http://$ip:$port/$1
}

# Points the browser to the named virtual host for the current
# settings. Assumes Apache is running as reverse proxy; see
# create_apache_vhoste_conf.sh for more information.
function djvirtualbrowse() {
    _verify_project_root_and_django_project || return 1
    _verify_django_settings_module || return 1

    local domain=local
    [ ! -z "$DOMAIN" ] && domain=`echo $DOMAIN | cut -f1 -d" "`
    local django_settings_id=`echo $DJANGO_SETTINGS_MODULE | sed 's#.*\\.##'`
    local PROJECT=`basename $PROJECT_ROOT`

    open_url http://$django_settings_id.$DJANGO_PROJECT.$PROJECT.$domain/$1
}

# Clear the cache via the Django cache API.
function clearcache() {
    python << EOF
from django.core.cache import cache
from django.db.transaction import commit_on_success

commit_on_success(cache.clear)()
EOF
}

# Gracefully restart Apache if configuration test is succesful.
function graceful() {
    sudo apachectl configtest && \
    sudo apachectl -k graceful && \
    echo "Apache restarted" 1>&2
}

# Make any Sphinx documentation. Provided arguments are passed to
# the make command, default is "dirhtml".
function makedocs() {
    if [ -d "$PROJECT_ROOT/doc" ]; then
        makefiles=`ls $PROJECT_ROOT/doc/*/Makefile 2>/dev/null`
        if [ -z "$makefiles" ]; then
            echo No documentation makefiles found 1>&2
            return 0
        fi
        for makefile in $makefiles; do
            dir=`dirname $makefile`
            echo "Making docs in $dir..."
            if [ "$1" ]; then
                args=$*
            else
                args=dirhtml
            fi
            make --directory $dir $args
            if [ $? -ne 0 ]; then
                return 1
            fi
        done
    fi
}

# Find all Django apps that have a locale directory.
function localized_django_projects() {
    _verify_project_root || return 1

    cdroot
    for directory in `find * -type d -name locale`; do
        directory=`dirname $directory`
        if [ -f $directory/models.py -o -f $directory/models/__init__.py ];
        then
            echo $directory
        fi
    done
}

# Deploy the current Django application (and most of the project).
function deploy() {
    _verify_project_root_and_django_project || return 1
    _verify_django_settings_module || return 1

    echo ">>> Updating virtualenv..." 1>&2 && pipup prd > /dev/null && \
        if [ -f "$PROJECT_ROOT/requirements/externals-prd.txt" ]; then
            echo ">>> Updating externals..." 1>&2 && externalsup prd
        else
            echo ">>> No production externals defined" 1>&2
        fi && \
        echo 1>&2 && echo ">>> Compiling Python code..." 1>&2 && pycompile > /dev/null && \
        echo ">>> Removing orphan .pyc files..." 1>&2 && removeorphanpycs > /dev/null && \
        echo ">>> Validating models..." 1>&2 && djadmin validate && \
        (echo 1>&2 && echo ">>> Compiling messages..." 1>&2
        get_django_setting INSTALLED_APPS | grep -q "'g0j0.i18n'"
        if [ $? -eq 0 ]; then
            # Use g0j0.i18n compilemessages if available
            djadmin compilemessages `localized_django_projects`
        else
            for dir in `localized_django_projects`; do
                (cdroot $dir && djadmin compilemessages)
            done
        fi) && \
        echo 1>&2 && echo ">>> Making documentation..." 1>&2 && makedocs && \
        echo 1>&2 && echo ">>> Collecting static files..." 1>&2 && \
            deploy_static && \
        echo 1>&2 && echo ">>> Setting permissions..." 1>&2 && set_permissions && \
        echo 1>&2 && echo ">>> Clearing cache..." 1>&2 && clearcache && \
        echo ">>> Restarting server..." 1>&2 && graceful && \
        echo 1>&2 && echo "Ok." 1>&2 && \
        return 0

    echo 1>&2 && echo "Errors encountered - deploy aborted." 1>&2
}

# Perform collectstatic --link based on a clean static directory
# to prevent conflicts. If $PROJECT_ROOT is a Mercurial repo,
# "hg revert" is issued on settings.STATIC_ROOT.
function deploy_static() {
    local static_root=`get_django_setting STATIC_ROOT`
    [ -z "$static_root" ] && echo "Warning: STATIC_ROOT not set" 1>&2 && return
    rm -rf $static_root/* && \
        if [ -d $PROJECT_ROOT/.hg ]; then
             hg revert --repository $PROJECT_ROOT $static_root
        fi && \
        djadmin collectstatic --link --noinput --verbosity=0
}

# TODO: document
function bootstrapproject() {
    _verify_project_root || return 1

    # Standard directories
    for dir in bin db doc externals lib log media requirements static tmp; do
        if [ ! -e $PROJECT_ROOT/$dir ]; then
            mkdir $PROJECT_ROOT/$dir
        fi
    done

    # Symlink to django-environments/etc
    [ ! -L $PROJECT_ROOT/etc ] && \
        ln -s externals/django-environments/etc $PROJECT_ROOT

    # Django is a basic requirement
    local libs=$PROJECT_ROOT/requirements/libs-prd.txt
    [ ! -e $libs ] && echo "Django" > $libs
    pipup prd || return 1

    # Get django-environments as an external
    local externals=$PROJECT_ROOT/requirements/externals-prd.txt
    [ ! -e $externals ] && echo $DJENV_HOME > $externals
    externalsup prd || return 1
}

# TODO: document
function bootstrapdjangoproject() {
    [ -z "$1" ] && \
        echo "Usage: bootstrapdjangoproject <Django project>" 1>&2 && return 1
    _verify_project_root || return 1

    local path=$PROJECT_ROOT
    for dir in $1 settings env; do
        path=$path/$dir
        if [ ! -d $path ]; then
            mkdir $path
            touch $path/__init__.py
        fi
    done
    echo "from .generic import *" > \
        $PROJECT_ROOT/$1/settings/__init__.py
    echo "from etc.settings import *" > \
        $PROJECT_ROOT/$1/settings/generic.py
    echo "from .. import *" > \
        $PROJECT_ROOT/$1/settings/env/local.py
}

# Start working on a project (first argument, optional second
# argument is the Django project, default "www"), automatically
# activating the virtualenv with the name of the project and selecting
# "settings.env.local". Virtualenv and empty project are created if
# they do not yet exist.
function djp() {
    [ -z "$1" ] && \
        echo "Usage: djp <project> [Django project]" 1>&2 && return 1

    # Exit a possible django environment
    djexit

    # Virtualenv
    [ -z "$PIP_VIRTUALENV_BASE" ] && PIP_VIRTUALENV_BASE=$DEFAULT_ROOT/virtualenvs
    if [ ! -d $PIP_VIRTUALENV_BASE/$1 ]; then
        echo "Virtual env $1 not found - create it? (y/n)" 1>&2
        read answer
        if [ "$answer" != "Y" -a "$answer" != "y" ]; then
            return 1
        fi

        echo "Creating virtualenv $1 in $PIP_VIRTUALENV_BASE" 1>&2
        virtualenv $PIP_VIRTUALENV_BASE/$1
        if [ $? -ne 0 ]; then
            echo "Error creating virtualenv $1" 1>&2
            return 1
        fi
    fi
    source $PIP_VIRTUALENV_BASE/$1/bin/activate
    if [ $? -ne 0 ]; then
        echo "Error activating virtualenv $1" 1>&2
        return 1
    fi

    # Project
    [ -z "$REPOS" ] && REPOS=$DEFAULT_REPOS
    if [ ! -d $REPOS/$1 ]; then
        mkdir $REPOS/$1
        local project_created=true
    fi
    setproject $REPOS/$1 > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Error changing project to $1" 1>&2
        return 1
    fi
    if [ $project_created ]; then
        bootstrapproject
        if [ $? -ne 0 ]; then
            echo "Error bootstrapping project" 1>&2
            return 1
        fi
    fi

    # Django project
    local django_project=$2
    [ -z "$django_project" ] && django_project=www
    if [ ! -e $PROJECT_ROOT/$django_project/settings/env/local.py ]; then
        bootstrapdjangoproject $django_project
    fi
    djenv $django_project settings.env.local
    if [ $? -ne 0 ]; then
        echo "Error setting Django project to $django_project" 1>&2
        return 1
    fi

    # Shell search path (virtualenv manages PATH for us)
    for bindir in $PROJECT_ROOT/*/*/bin $PROJECT_ROOT/*/bin $PROJECT_ROOT/bin; do
        if [ -d $bindir ]; then
            PATH=$bindir:$PATH
        fi
    done
}

# Clean up the environment.
function _djenv_cleanup () {
    unset DJANGO_PROJECT DJANGO_SETTINGS \
        _OLD_DJANGO_SETTINGS_MODULE _OLD_PYTHONPATH \
        DJANGO_TEMPLATE_DIRS DJANGO_FIXTURE_DIRS
}

# Use _djenv_register_cleanup to register your own cleanup functions
_djenv_register_cleanup _djenv_cleanup

function show_projects() {
    (
        [ -z "$REPOS" ] && REPOS=$DEFAULT_REPOS
        cd $REPOS
        shopt -s nullglob
        find * -maxdepth 0 -type d
    )
}

function show_django_projects() {
    [ ! -z "$1" ] || _verify_project_root || return 1

    (
        [ ! -z "$1" ] && PROJECT_ROOT=$REPOS/$1
        cd $PROJECT_ROOT
        shopt -s nullglob
        for file in */settings/__init__.py; do
            echo $file
        done
    ) | sed 's#/settings/__init__.py##' | sort
}

function show_django_settings() {
    _verify_project_root || return 1

    (
        cd $PROJECT_ROOT/$1
        shopt -s nullglob
        for file in settings/env/*.py; do
            echo $file
        done
    ) | grep -v '/__init__.py$' | sed 's#settings/env/#settings.env.#' | \
        sed 's#\.py$##' | sort
}

# Export functions so they can be used in shell scripts
export -f _djenv_init _djenv_register_cleanup _verify_project_root _verify_django_project \
    _verify_project_root_and_django_project _verify_django_settings_module \
    djexit djenv get_django_setting import_django_settings cdroot cdlib \
    pipup _externals externalsup pycompile removeorphanpycs cleanupdirs removeemptydirs \
    cdjango djadmin get_network_ip runserver testserver open_url djbrowse djvirtualbrowse \
    clearcache graceful localized_django_projects makedocs deploy deploy_static \
    _djenv_cleanup show_projects show_django_projects show_django_settings

#
# Tab completion
#

_projects_complete() {
    local current="${COMP_WORDS[COMP_CWORD]}"
    local previous="${COMP_WORDS[COMP_CWORD - 1]}"

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=($(compgen -W "`show_projects`" -- ${current}))
    elif [ $COMP_CWORD -eq 2 ]; then
        COMPREPLY=( $(compgen -W "`show_django_projects $previous`" -- ${current}) )
    fi
}

_django_projects_complete() {
    local current="${COMP_WORDS[COMP_CWORD]}"
    local previous="${COMP_WORDS[COMP_CWORD - 1]}"

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=($(compgen -W "`show_django_projects`" -- ${current}))
    elif [ $COMP_CWORD -eq 2 ]; then
        COMPREPLY=( $(compgen -W "`show_django_settings $previous`" -- ${current}) )
    fi
}

_cdroot_complete() {
    _verify_project_root || return 1

    COMPREPLY=($(cdroot && compgen -d -- "${2}"))
}

_cdlib_complete() {
    _verify_project_root || return 1

    COMPREPLY=($(cdlib && compgen -d -- "${2}"))
}

_cdjango_complete() {
    _verify_django_project || return 1

    COMPREPLY=($(cdjango && compgen -d -- "${2}"))
}

function show_requirements_environments() {
    _verify_project_root || return 1

    (
        cd $PROJECT_ROOT/requirements
        shopt -s nullglob
        for file in $1-*.txt; do
             echo $file
        done
    ) | sed "s#$1-##" | sed 's#.txt##' | sort
}

_pipup_complete() {
    _verify_project_root || return 1

    COMPREPLY=($(compgen -W "`show_requirements_environments libs`" -- "${2}" ))
}

_externalsup_complete() {
    _verify_project_root || return 1

    COMPREPLY=($(compgen -W "`show_requirements_environments externals`" -- "${2}" ))
}

complete -o nospace -F _cdroot_complete -S/ cdroot
complete -o nospace -F _cdlib_complete -S/ cdlib
complete -o nospace -F _cdjango_complete -S/ cdjango
complete -F _projects_complete djp
complete -F _django_projects_complete djenv
complete -F _pipup_complete pipup
complete -F _externalsup_complete externalsup
