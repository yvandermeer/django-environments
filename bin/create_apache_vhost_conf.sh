#!/usr/bin/env bash
#
# Generates Apache named virtual host configuration for reverse
# proxying runserver instances, to be included from your Apache
# configuration.
#
# This way, you can have unlimited Django runserver instances running
# at the same time, each one listening on a different port as specified
# in the settings. This makes life easier when working with multiple
# Django projects simultaneously, but it also allows comparison between
# different settings within a single Django project, for instance the
# performance of two different database backends.
#
# Either set settings.LOCAL_SERVER_PORT to the port you want to use
# for a given Django project (in settings/generic.py), and optionally
# overrule settings.LOCAL_SERVER_PORT in a specific environment
# settings file, like settings/env/dev_postgresql.py. (It's a good
# idea to have a port numbering strategy ready before you start, just
# like with BASIC line numbers: 7000-7099 project A, 7100-7199 project
# B and so on.)
#
# By default, the generated virtual hosts will have the naming formats
# 'django_project_id.local' and 'settings_id.django_project_id.local'.
# By defining environment variable $DOMAIN you can change the domain
# postfix to anything you like, for instance
# 'development.myorganization.dom'. If you need to create additional
# ServerAlias directives, just add more domains to $DOMAIN, like so:
# 'development.myorganization.dom demos.myorganization.dom'.
#
# Steps to get this working:
#
# 1. Run this script and save the output to a file, for instance
#    create_apache_vhost_conf.sh > $PROJECT_ROOT/deploy/vhosts-development.conf
#    (It's good idea to do this in a VCS hook to always keep it up-to-date.)
#
# 2. Include the configuration file in your Apache configuration:
#    Include /Users/spanky/repos/myproject/deploy/vhosts-development.conf
#
# 3. Restart Apache.
#
# 4. For each of the generated virtual hosts you wish to use, add
#    the host name to the localhost entry in /etc/hosts:
#    127.0.0.1 localhost django_project_id.local
#
#    Or, even better: use a DNS server that supports wildcards! This
#    way you simply have to make sure that *.development.myorganization.dom
#    points to 127.0.0.1, and you're done.
#
# 5. Use 'djenv django_project_id settings_id', followed by 'runserver'
#    to have a Django server listening at the port you specified in the
#    settings. Note you will have to use the 'runserver' function as
#    provided by django-environments to have the server actually listen
#    on settings.LOCAL_SERVER_PORT.
#
# 6. Go to the appropriate URL, e.g.
#    http://settings_id.django_project_id.local/ and admire your work.

domains=local
[ ! -z "$DOMAIN" ] && domains=$DOMAIN

# The root of the project should exist, of course
[ -z "$PROJECT_ROOT" ] && \
    echo "Variable \$PROJECT_ROOT not set or empty" 1>&2 && exit 1
[ ! -d "$PROJECT_ROOT" ] && \
     echo "Variable \$PROJECT_ROOT does not point to a readable directory" 1>&2 && exit 1

PROJECT=`basename $PROJECT_ROOT`

cd `dirname $0`

function write_vhost() {
    echo '<VirtualHost *:*>'

    local directive=ServerName # First domain is the server name
    for domain in $domains; do
        echo "    $directive $1.$2.$domain"
        directive=ServerAlias # The other domains are aliases
    done

    cat << EOF
    RewriteEngine On
    RewriteRule ^/favicon.ico [F]
    RewriteRule ^/$4/(.*) $5/\$1 [L]
    RewriteRule ^/$6/(.*) $7/\$1 [L]
    RewriteRule ^/(.*) http://127.0.0.1:$3/\$1 [P]
</VirtualHost>

EOF
}

    cat << EOF
# >>> Generated django-environments virtual host config start

NameVirtualHost *:*

<Directory "$PROJECT_ROOT">
    Order deny,allow
    Allow from all
</Directory>

EOF

# Skip the etc directory, it only looks like a Django project
for django_project_dir in `ls -d $PROJECT_ROOT/* | grep -v etc$`; do

    # Generic settings
    if [ -f "$django_project_dir/settings.py" -o \
         -d "$django_project_dir/settings" ]; then
        export DJANGO_PROJECT=`basename $django_project_dir`

        echo "#" $PROJECT $DJANGO_PROJECT \($django_project_dir\)

        port=`get_django_setting LOCAL_SERVER_PORT 8000 $DJANGO_PROJECT.settings`
        static_root=`get_django_setting STATIC_ROOT static $DJANGO_PROJECT.settings`
        static_id=`get_django_setting STATIC_ID static $DJANGO_PROJECT.settings`
        media_root=`get_django_setting MEDIA_ROOT media $DJANGO_PROJECT.settings`
        media_id=`get_django_setting MEDIA_ID static $DJANGO_PROJECT.settings`
        write_vhost $DJANGO_PROJECT $PROJECT $port $static_id $static_root $media_id $media_root

        # Per-environment settings
        for settings in $django_project_dir/settings/env/*.py; do

            # Skip __init__.py and non-file directory entries
            if [ `basename $settings` = "__init__.py" -o ! -f "$settings" ]; then
                continue
            fi

            django_settings=`echo $settings | sed "s#$PROJECT_ROOT/##" | \
                             sed "s#[^/]*/settings/env/#settings.env.#" | sed 's#.py$##'`
            django_settings_id=`echo $django_settings | sed "s#.*\\.##"`

            echo "#" $PROJECT $DJANGO_PROJECT $django_settings_id \($django_project_dir\)
            port=`get_django_setting LOCAL_SERVER_PORT 8000 $DJANGO_PROJECT.$django_settings`
            static_root=`get_django_setting STATIC_ROOT static $DJANGO_PROJECT.settings`
            static_id=`get_django_setting STATIC_ID static $DJANGO_PROJECT.settings`
            media_root=`get_django_setting MEDIA_ROOT media $DJANGO_PROJECT.settings`
            media_id=`get_django_setting MEDIA_ID static $DJANGO_PROJECT.settings`
            write_vhost $django_settings_id.$DJANGO_PROJECT $PROJECT $port $static_id $static_root $media_id $media_root
        done

    fi
done

echo '# <<<' Generated django-environments virtual host config end
