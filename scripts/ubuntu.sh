#!/usr/bin/env bash

# this script can be used to install
# docker + postgis and create a DB in ubuntu.

sudo apt-get update
sudo apt-get -y install docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io

bash ./docker.sh
