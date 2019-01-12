#!/bin/bash
set -e

$HOME/initialise.sh 2048
nohup omero admin start  > /dev/null 2>&1 &

exec "$@"
