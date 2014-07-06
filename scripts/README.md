The scripts in this directory rely on one another in their current form
and should be kept together.

The `Dockerfile` and various scripts and lists here are provided in case you want to
build the Docker container from scratch. By Default, Vagrant will provision itself with
a pre-built image.  See the commented section near the top of `../Vagrantfile`.

To update the list of SQL files being pulled from pin13.net, modify `sql.list`.

`ubuntu.sh` will install docker for ubuntu, start running a container with postgis,
and insert the car2go data.

`docker.sh` starts running a container with postgis and inserts the car2go data.

`pgsetup.sh` fetches and inserts the car2go data.
