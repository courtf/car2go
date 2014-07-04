The scripts in this directory rely on one another in their current form
and should be kept together.

`ubuntu.sh` will install docker for ubuntu, start running a container with postgis,
and insert the car2go data.

`docker.sh` starts running a container with postgis and inserts the car2go data.

The idea is that `docker.sh` can be run on OSX or Linux/Vagrant.
