# OMERO in Jupyter

Run OMERO inside Jupyter!


## Mybinder
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/manics/omero-server-jupyter/master)

Start OMERO.web by clicking the OMERO.web launcher icon. This will launch a new tab.

**WARNING:**
mybinder.org limits the available memory to 2 GB which is insufficient for OMERO.server inside the container.
mybinder.org also prevents outgoing network access on the standard OMERO ports so even if you configure OMERO.web to connect to an external server you will not be able to login to OMERO.web unless the OMERO.server is listening on a web port.


## Quickstart

1. Launch the container.
2. Start a terminal. Run `./intialise.sh` to start PostgreSQL and initialise the OMERO.
3. Start OMERO.server: `omero admin start`
4. Start OMERO.web by clicking the OMERO.web launcher icon. This will launch a new tab. Login as user `root` password `omero`.


## Configuration

`omero` is in the standard `PATH` so you can configure OMERO by running `omero config` in the terminal before starting OMERO.server or OMERO.web.
