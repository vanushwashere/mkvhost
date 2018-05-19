#!/bin/bash

help="Usage: mkvhost.sh YOUR_HOST_WITHOUT_TLD YOUR_LOCAL_PORT \n(exp. ./mkvhost.sh foobar 8080 will create foobar.localhost virtual host that will proxy_pass to http://localhost:8080)\n"

# Print help message if asked for
if [[ $1 = "-h" || $1 = "--help" ]]; then
        printf "${help}"
        exit
fi

if [[ $(id -u) -ne 0 ]] ; then
	echo "Please run as root";
	exit 1;
fi

if [ "$#" -ne 2  ] ; then
	echo "Please provide host and port"
	exit;
fi

HOST=$1;
PORT=$2;
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

echo "Creating vhost file..."
cp $DIR/.localhost $DIR/$HOST.localhost

HOSTFILE="${DIR}/${HOST}.localhost"
echo "Host file created: ${HOSTFILE}"

echo "Replacing HOST and PORT"

STR=$"HOST=${HOST}"$'\n'"PORT=${PORT}"

while read line || [[ -n "$line" ]]
do
    key=$(awk -F= '{print $1}' <<< "$line")
    value=$(awk -F= '{print $2}' <<< "$line")
    sed -i 's/${'"$key"'}/'"$value"'/g' $HOSTFILE
done <<< "$STR"

echo "Final nginx config generated."

echo "Copying to /etc/nginx/sites-available/"
cp "${HOSTFILE}" "/etc/nginx/sites-available/"

echo "Symlinking config to /etc/nginx/sites-enabled/"
ln -s "/etc/nginx/sites-available/${HOST}.localhost" "/etc/nginx/sites-enabled/${HOST}.localhost"

echo "Removing temp files"
rm -f $HOSTFILE
exit;
