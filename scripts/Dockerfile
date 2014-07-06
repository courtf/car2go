FROM paintedfox/postgresql
MAINTAINER Court Fowler <courtf@gmail.com>

# uncomment to use digitalocean's mirrors (sometimes much faster)
#ADD     scripts/sources.list /etc/apt/sources.list
RUN     sudo apt-get update
RUN     sudo apt-get -y install postgresql-9.3-postgis-2.1
