# OMERO in Jupyter

Run OMERO inside Jupyter!


## Mybinder
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/manics/omero-server-jupyter/master?urlpath=lab)

Start OMERO.web by clicking the OMERO.web launcher icon. This will launch a new tab.

**WARNING:**
mybinder.org limits the available memory to 2 GB which may prevent OMERO.server from running properly.
mybinder.org also prevents outgoing network access on the standard OMERO ports so even if you configure OMERO.web to connect to an external server you will not be able to login to OMERO.web unless the OMERO.server is listening on a web port.
If you get a timeout whilst launching OMERO.web refresh the page.


## Quickstart

1. Launch the container.
2. Start OMERO.web by clicking the OMERO.web launcher icon. This will launch a new tab. Login as user `root` password `omero`.

The container startup procedure uses a Docker container entrypoint that runs the `./intialise.sh` to start PostgreSQL and initialise OMERO.server and then start the OMERO.server by issuing the `omero admin start` command.

## Configuration

`omero` is in the standard `PATH` so you can configure OMERO by running `omero config` in the terminal before starting OMERO.server or OMERO.web.
