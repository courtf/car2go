car2go
======

A little repo to automate setting up some historical data from car2go in postgis.

I've provided a `Vagrantfile`, which works with `vagrant up`. Modify the `config.json` to your liking beforehand, and then `vagrant ssh` and use `psql` to your heart's content.

Once ssh'd into the guest, you should be able to psql in to the db as shown below, replacing `car2go car2go` with
your DB username and DB name, if you changed them in `config.json`.

```shell
$ PGPASSFILE=/vagrant/scripts/pgpass psql -h 127.0.0.1 -U car2go car2go
```
Or, if you don't mind the password prompt:
```
$ psql -h 127.0.0.1 -U car2go car2go
```

##### Notes:

When accessing Docker directly from within the guest machine, you may get tired of having to preface all your commands with `sudo`.
Please look [here](http://docs.docker.com/installation/ubuntulinux/#giving-non-root-access) for how to add yourself to the docker group.

I've tried a couple other methods of making this faster/easier, but ran into lots of problems:

1. Attempted to use the automated Docker provisioning for Vagrant described [here](http://docs.vagrantup.com/v2/provisioning/docker.html).
This consistently resulted in PGP failures from within Vagrant's provisioning code.  I opted to just install docker.io directly...

2. Attempted to commit, tag and push the fully built container (which worked) and then pull it back down and run it again.  See: https://registry.hub.docker.com/u/courtf/car2go/
After pulling and starting up the docker container with `docker pull` and `docker run`, psql refused to maintain a connection:
`server closed the connection unexpectedly`.

3. Attempted to open ports out to the host OS (wherever vagrant is being run). I followed instructions [here](http://maori.geek.nz/post/vagrant_with_docker_how_to_set_up_postgres_elasticsearch_and_redis_on_mac_os_x).
This ended up with the same PGP errors as #1, and also seemed to break using `vagrant destroy` and `vagrant ssh` from the build directory.


##### Thanks:
Much thanks to these other repos for a great Docker starting point:

https://github.com/Painted-Fox/docker-postgresql

https://github.com/phusion/baseimage-docker
