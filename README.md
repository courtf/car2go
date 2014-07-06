car2go
======

A little repo to automate setting up some historical data from car2go in postgis.

I've provided a `Vagrantfile`, which does work with `vagrant up`, but the port forwarding doesn't seem to work
from the host -> Vagrant -> Docker.  Not sure why, but you can still `vagrant ssh` and use `psql` to your heart's
content.  Modify the `config.json` to your liking beforehand.

All you should need to do is:
```shell
$ vagrant up
```

Followed by:
```shell
$ vagrant ssh
```

Once ssh'd into the guest, you should be able to psql in to the db as shown below, replacing `car2go car2go` with
your DB username and DB name, if you changed them in `config.json`.

```shell
$ PGPASSFILE=/vagrant/scripts/pgpass psql -h 127.0.0.1 -U car2go car2go

# Or, if you don't mind the password prompt:

$ psql -h 127.0.0.1 -U car2go car2go
```

##### Notes:

When accessing Docker directly from within the guest machine, you may get tired of having to preface all your commands with `sudo`.
Please look [here](http://docs.docker.com/installation/ubuntulinux/#giving-non-root-access) for how to add yourself to the docker group.

`car2go.go` is just a rudimentary connection to the database in Go. It is intended that we can write our benchmark
code in several languages to be included alongside.

##### Thanks:
Much thanks to these other repos for a great Docker starting point:

https://github.com/Painted-Fox/docker-postgresql

https://github.com/phusion/baseimage-docker
