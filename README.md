car2go
======

#### Work In progress!

A little repo to automate setting up some historical data from car2go in postgis.

If you are running on OSX, you should set up [boot2docker](https://docs.docker.com/installation/mac/). And then
you can use the provided `Dockerfile` to set up postgis etc.

If you want to run in Vagrant/Ubuntu, feel free to use the provided `ubuntu_docker_postgis.sh` script to install
everything you would need.  Modify the `config.json` to your liking beforehand.

I've provided a `Vagrantfile`, which does work with `vagrant up`, but the port forwarding doesn't seem to work
from the host -> Vagrant -> Docker.  Not sure why, but you can still `vagrant ssh` and use `psql` to your heart's
content:
```shell
$ sudo apt-get install postgresql-client
```

`car2go.go` is just a rudimentary connection to the database in Go. It is intended that we can write our benchmark
code in several languages to be included alongside.

Much thanks to these other repos for a great Docker starting point:
https://github.com/Painted-Fox/docker-postgresql
https://github.com/phusion/baseimage-docker
