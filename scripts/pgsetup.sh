#!/usr/bin/env bash

# this script should be run once postgres has
# been set up successfully. it will create the
# necessary tables and populate the database.

source ./config.sh && config_vars

# set up pgpassfile
# http://www.postgresql.org/docs/9.3/interactive/libpq-pgpass.html
pstr="$host:$port:$dbname:$user:$pass"
if [[ ! -f pgpass || ! grep -q $pstr pgpass]]; then
    echo $pstr >> pgpass && chmod 0600 pgpass
fi

# see: http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
export PGPASSFILE="$DIR/pgpass"

# pg server likes to puke here, and needs to rest a moment
sleep 2

echo "Creating car2go tables ..."
psql -h $host -p $port -U $user $dbname -q <<-EOF
    CREATE EXTENSION postgis;
    CREATE TABLE "vehicles" ("id" serial UNIQUE, "plate" varchar(6) COLLATE "default","vin" varchar(30) COLLATE "default");
    CREATE INDEX "vehicles_pkey" ON "vehicles" USING btree("id" ASC NULLS LAST);
    CREATE TABLE "positions" ("id" serial UNIQUE NOT NULL,"vehicle_id" int4,"fuel_level" int2,"interior_good" bool,"exterior_good" bool,"date" timestamp(6) NULL,"location" "geography");
    CREATE INDEX "positions_pkey" ON "positions" (id);
    CREATE INDEX "position_gist" ON "positions" USING GIST (location);
    CREATE INDEX "position_date" ON "positions" (date);
EOF

echo "Fetching car2go data ..."
wget http://pin13.net/car2go/data/2012-06.sql.gz
wget http://pin13.net/car2go/data/2012-07.sql.gz
wget http://pin13.net/car2go/data/2012-08.sql.gz
wget http://pin13.net/car2go/data/2012-09.sql.gz
wget http://pin13.net/car2go/data/2012-10.sql.gz
wget http://pin13.net/car2go/data/2012-12.sql.gz
wget http://pin13.net/car2go/data/2013-01.sql.gz
wget http://pin13.net/car2go/data/2013-02.sql.gz
wget http://pin13.net/car2go/data/2013-03.sql.gz
wget http://pin13.net/car2go/data/2013-04.sql.gz
wget http://pin13.net/car2go/data/2013-05.sql.gz
wget http://pin13.net/car2go/data/2013-06.sql.gz
wget http://pin13.net/car2go/data/2013-07.sql.gz
wget http://pin13.net/car2go/data/2013-08.sql.gz
wget http://pin13.net/car2go/data/2013-09.sql.gz
wget http://pin13.net/car2go/data/2013-10.sql.gz
wget http://pin13.net/car2go/data/2013-11.sql.gz
wget http://pin13.net/car2go/data/2013-12.sql.gz
wget http://pin13.net/car2go/data/sample.sql.gz
wget http://pin13.net/car2go/data/vehicles.sql.gz
gunzip *.gz

echo "Inserting car2go data. This will likely take multiple hours ..."
for file in *.sql; do
    psql -q -h $host -p $port -U $user $dbname -f "$file"
done

# set our serial id columns to their current max so that any future
# inserts will start at the correct position in the sequence
psql -h $host -p $port -U $user $dbname -q <<-EOF
    SELECT setval('vehicles_id_seq', (SELECT MAX(id) FROM vehicles));
    SELECT setval('positions_id_seq', (SELECT MAX(id) FROM positions));
EOF

# cleanup our downloads
rm *.sql
rm *.gz

echo "complete!"
