#!/bin/bash

source activate python2

set -eux

env

PORT="$1"
# Strip trailing /
BASE_URL="${2%/}"

# Set to 1 to log to stdout instead of OMEROweb.log
OMERO_WEB_STDOUT=0

omero=/opt/omero/server/OMERO.server/bin/omero

#$omero config set omero.web.prefix $BASE_URL/omeroweb
#$omero config set omero.web.static_url $BASE_URL/omeroweb/static/
#$omero config set omero.web.prefix $BASE_URL/proxy/$PORT

$omero config append --set omero.web.django_additional_settings '["WHITENOISE_STATIC_PREFIX", "/static/"]'
if [ "$OMERO_WEB_STDOUT" = 1 ]; then
  $omero config append --set omero.web.django_additional_settings '["LOGGING",
    {
      "version": 1,
      "disable_existing_loggers": false,
      "formatters": {
        "standard": {
          "format": "%(asctime)s %(levelname)5.5s [%(name)40.40s] (proc.%(process)5.5d) %(funcName)s():%(lineno)d %(message)s"
        }
      },
      "handlers": {
        "console": {
          "level": "DEBUG",
          "class": "logging.StreamHandler",
          "formatter": "standard"
        }
      },
      "loggers": {
        "": {
          "handlers": ["console"],
          "level": "DEBUG",
          "propagate": true
        }
      }
    }
  ]'
fi
$omero config set omero.web.static_url $BASE_URL/proxy/$PORT/static/
$omero config set omero.web.application_server.port $PORT

# Just in case OMERO.web is already running
$omero web stop
$omero web start --foreground
