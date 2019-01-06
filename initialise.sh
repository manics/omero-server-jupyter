#!/bin/bash

set -eux

PGDATA=${PGDATA:-/home/jovyan/srv/pgsql}
OMERODATA=${OMERODATA:-/home/jovyan/srv/omero}
MEMORY=${1:-3072}

if [ ! -d "$PGDATA" ]; then
  /usr/lib/postgresql/10/bin/initdb -D "$PGDATA" --auth-host=md5 --encoding=UTF8
fi
/usr/lib/postgresql/10/bin/pg_ctl -D "$PGDATA" status || /usr/lib/postgresql/10/bin/pg_ctl -D "$PGDATA" -l "$PGDATA/pg.log" start

if [ ! -d "$OMERODATA" ]; then
  source activate python2
  psql postgres -c "CREATE USER omero PASSWORD 'omero'"
  createdb -O omero omero
  omego db init --serverdir=/opt/omero/server/OMERO.server --dbname=omero

  echo "Creating omero.data.dir $OMERODATA"
  /opt/omero/server/OMERO.server/bin/omero config set omero.data.dir "$OMERODATA"
  mkdir -p "$OMERODATA"
fi

if [ "$MEMORY" -lt 3072 ]; then
  omero config set omero.jvmcfg.system_memory $MEMORY
  omero config set omero.jvmcfg.percent.blitz 50
  omero config set omero.jvmcfg.percent.pixeldata 10
  omero config set omero.jvmcfg.percent.indexer 10
fi

echo "Run 'omero admin start' to start OMERO.server"
