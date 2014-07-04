FROM paintedfox/postgresql
MAINTAINER Court Fowler <courtf@gmail.com>

RUN     sudo apt-get update
RUN     sudo apt-get install postgresql-9.3-postgis-2.1
