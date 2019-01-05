#!/bin/bash

source activate python2

set -eux

env

PORT="$1"
# Strip trailing /
BASE_URL="${2%/}"

omero=/opt/omero/server/OMERO.server/bin/omero

#$omero config set omero.web.prefix $BASE_URL/omeroweb
#$omero config set omero.web.static_url $BASE_URL/omeroweb/static/
#$omero config set omero.web.prefix $BASE_URL/proxy/$PORT
sed -i 's%WHITENOISE_STATIC_PREFIX =.*%WHITENOISE_STATIC_PREFIX = "/static/"%' /opt/omero/server/OMERO.server/lib/python/omeroweb/settings.py

$omero config set omero.web.static_url $BASE_URL/proxy/$PORT/static/
$omero config set omero.web.application_server.port $PORT

$omero web start --foreground
