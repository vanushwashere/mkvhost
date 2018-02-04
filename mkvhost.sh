#!/bin/bash

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

echo "Creating vhost file..."
cp ./.localhost ./$HOST.localhost

HOSTFILE="${HOST}.localhost"
echo "Host file created."

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
cp ./$HOSTFILE /etc/nginx/sites-available/

echo "Symlinking config to /etc/nginx/sites-enabled/"
ln -s /etc/nginx/sites-available/$HOSTFILE /etc/nginx/sites-enabled/$HOSTFILE

echo "Removing temp files"
rm -f ./$HOSTFILE
exit;
