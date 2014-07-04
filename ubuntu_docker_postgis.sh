#!/usr/bin/env bash

# this script can be used to install
# docker + postgis and create a DB.
# unnecessary if you are using boot2docker on OSX.

function get_val {
    echo $(sed -n "s/^ *\"$1\": *\"*\([a-z0-9A-Z.]*\)\"* *,*/\1/p" /vagrant/config.json)
}

sudo apt-get update
sudo apt-get -y install docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io

user=$(get_val User)
pass=$(get_val Pass)
host=$(get_val Host)
port=$(get_val Port)
dbname=$(get_val DBName)

if [[ -z $user ]]; then
    echo 'No user found, add "User" to config.json'
    exit 0
fi

if [[ -z $pass ]]; then
    echo 'No password found, add "Pass" to config.json'
    exit 0
fi

if [[ -z $host ]]; then
    echo 'No host found, add "Host" to config.json'
    exit 0
fi

if [[ -z $port ]]; then
    echo 'No port found, add "Port" to config.json'
    exit 0
fi

if [[ -z $dbname ]]; then
    echo 'No dbname found, add "DBName" to config.json'
    exit 0
fi

echo "==> Starting docker build, this may take a while ..."
sudo docker build -t="$user/$dbname" /vagrant
docker run -d --name="postgresql" \
    -p $host:$port:$port \
    -v /tmp/postgresql:/data \
    -e USER="$user" \
    -e PASS="$pass" \
    -e DB="$dbname" \
    $user/$dbname
