FROM imagedata/jupyter-docker:0.9.0

USER root
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 5E6DA83306132997 && \
    /bin/echo "deb http://zeroc.com/download/Ice/3.6/ubuntu16.04 stable main" > /etc/apt/sources.list.d/zeroc.list && \
    /bin/echo -e 'Package: zeroc-*\nPin: origin zeroc.com\nPin-Priority: 1000' > /etc/apt/preferences.d/zeroc && \
    apt-get update && \
    apt-get install -qq -y \
        openjdk-8-jre \
        postgresql \
        zeroc-ice-all-runtime && \
    install -d /opt/omero/server -o jovyan && \
    chown jovyan /run/postgresql/

USER jovyan
RUN /opt/conda/envs/python2/bin/pip install omego && \
    cd /opt/omero/server && \
    /opt/conda/envs/python2/bin/omego download server --ice=3.6 --sym auto

# Already installed:
# - IcePy (bioconda/zeroc-ice)

COPY omero.sh /usr/local/bin/omero
COPY initialise.sh /home/jovyan/
