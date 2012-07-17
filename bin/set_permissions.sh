#!/usr/bin/env bash

set -e

directories=''
for directory in `localized_django_projects`; do
    directories="$directories $directory/locale/*/LC_MESSAGES"
done
directories="$directories db log static/generated static/medialibrary */deploy"

# The root of the project should exist, of course
[ -z "$PROJECT_ROOT" ] && \
    echo "Variable PROJECT_ROOT not set or empty" 1>&2 && exit 1
[ ! -d "$PROJECT_ROOT" ] && \
     echo "Variable PROJECT_ROOT does not point to a readable directory" 1>&2 && exit 1

cd $PROJECT_ROOT

user=$HTTP_USER
[ -z "$user" ] && user=www-data
group=$HTTP_GROUP
[ -z "$group" ] && group=`groups | awk '{ print $1 }'`

dirs=$*
if [ -z "$dirs" ]; then
    dirs=$directories
fi

for dir in $dirs; do
    [ ! -d "$dir" ] && continue
    echo Setting permissions in $dir...
    sudo chown -R $user:$group $dir
    sudo chmod -R u=rw,+X,g=rw,+X $dir
    sudo find $dir -type d -exec chmod g+rws {} \;
done
