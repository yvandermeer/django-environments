#
# Initialize the settings environment
#
# Should be sourced with the 'source' command, e.g. 'source initenv'
#
# The source command can be performed within virtualenvwrapper's
# bin/postdeactivate, or you could just copy the following lines
# to bin/postdeactivate. Alternatively, you may also symlink
# bin/postdeactivate to (a custom version of) this file.

# The root of the project, i.e. the directory containing your Django projects
# PROJECT_ROOT=/Users/joe/projects/myproject
PROJECT_ROOT=`dirname $(dirname "${BASH_SOURCE[0]}")`

# Show primary settings after chaning project and settings using djenv
SHOW_DJANGO_ENVIRONMENT=yes

source djenvlib.sh

# Switch environment to Django project mysite, using development settings
djenv mysite settings.env.development

# Make sure we use sqlite for this example project
export DJANGO_DATABASE_TYPE=sqlite

# Domain for virtual host configuration - optional (see
# bin/create_apache_vhost_conf.sh)
#export DOMAIN=local.mysite.org

# For your convenience: these two lines help greatly when using pip
# with virtualenv, see http://pip.openplans.org/
#export PIP_REQUIRE_VIRTUALENV=true PIP_RESPECT_VIRTUALENV=true
