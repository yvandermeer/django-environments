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
    echo "Variable \$PROJECT_ROOT not set or empty" 1>&2 && exit 1
[ ! -d "$PROJECT_ROOT" ] && \
     echo "Variable \$PROJECT_ROOT does not point to a readable directory" 1>&2 && exit 1

cd `dirname $0`

echo '# >>>' Generated django-environments virtual host config start
echo
echo NameVirtualHost 127.0.0.1:*
echo

for django_project_dir in $PROJECT_ROOT/*; do

    # Generic settings
    if [ -f "$django_project_dir/settings.py" -o \
         -d "$django_project_dir/settings" ]; then
        django_project=`basename $django_project_dir`

        echo '#' $django_project
        export PYTHONPATH=`dirname $django_project_dir`
        export DJANGO_SETTINGS_MODULE=$django_project.settings
        port=`get_django_setting LOCAL_SERVER_PORT`

        cat << EOF
<VirtualHost 127.0.0.1:*>
    ServerName $django_project.$domain
    RewriteEngine On
    RewriteRule ^/(.*) http://localhost:$port/\$1 [P]
</VirtualHost>
EOF

        # Environment settings
        for settings in $django_project_dir/settings/env/[a-z]*py; do
            django_project_dir=`echo $settings | sed "s#/settings/env/.*py##"`
            django_project=`basename $django_project_dir`
            django_settings=`echo $settings | sed "s#$PROJECT_ROOT/##" | sed "s#[a-z]*/settings/env/#settings.env.#" | sed 's#.py$##'`
            django_settings_id=`echo $django_settings | sed "s#.*\\.##"`

            echo '#' $django_project $django_settings

            export PYTHONPATH=`dirname $django_project_dir`
            export DJANGO_SETTINGS_MODULE=$django_project.$django_settings
            port=`get_django_setting LOCAL_SERVER_PORT`

            cat << EOF
<VirtualHost 127.0.0.1:*>
    ServerName $django_settings_id.$django_project.$domain
    RewriteEngine On
    RewriteRule ^/(.*) http://localhost:$port/\$1 [P]
</VirtualHost>
EOF
        done

        echo
    fi
done

echo '# <<<' Generated django-environments virtual host config end
