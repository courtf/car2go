#!/usr/bin/env bash

# this script runs an existing build, courtf/car2go
# according to the provided config

source ./config.sh && config_vars

echo "==> Starting docker build, this may take a while ..."
#    -v /tmp/postgresql:/data \
sudo docker build -t="car2go" .. && \
sudo docker run -d --name="car2go" \
    -p $host:$port:$port \
    -e USER="$user" \
    -e PASS="$pass" \
    -e DB="$dbname" \
    car2go && \
bash ./pgsetup.sh
