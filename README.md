car2go
======

#### Work In progress!

A little repo to automate setting up some historical data from car2go in postgis.

If you are running on OSX, you should set up [boot2docker](https://docs.docker.com/installation/mac/). And then
you can use the provided scripts to set up postgis etc:
```shell
$ cd scripts/ && ./docker.sh
```

If you want to run in Vagrant/Ubuntu, feel free to use the provided `scripts/ubuntu.sh` script to install
everything you would need.  Modify the `config.json` to your liking beforehand.

Make sure to cd before running the scripts, as they use relative paths. For example in Vagrant:
```shell
cd /vagrant/scripts && ./ubuntu.sh
```

I've provided a `Vagrantfile`, which does work with `vagrant up`, but the port forwarding doesn't seem to work
from the host -> Vagrant -> Docker.  Not sure why, but you can still `vagrant ssh` and use `psql` to your heart's
content.

##### Notes:

When accessing directly in Vagrant/Ubuntu, you may get tired of having to preface all your commands with `sudo`.
Please look [here](http://docs.docker.com/installation/ubuntulinux/#giving-non-root-access) for how to add yourself to the docker group.

`car2go.go` is just a rudimentary connection to the database in Go. It is intended that we can write our benchmark
code in several languages to be included alongside.

##### Thanks:
Much thanks to these other repos for a great Docker starting point:

https://github.com/Painted-Fox/docker-postgresql

https://github.com/phusion/baseimage-docker
