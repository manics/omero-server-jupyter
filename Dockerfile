FROM imagedata/jupyter-docker:0.9.0

USER root
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 5E6DA83306132997 && \
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

RUN conda install -n python2 -y -q \
    numpy \
    Pillow \
    'Django=1.8.*' \
    gunicorn \
    whitenoise && \
    /opt/conda/envs/python2/bin/pip install -r /opt/omero/server/OMERO.server/share/web/requirements-py27.txt

RUN pip install https://github.com/manics/jupyter-server-proxy/archive/proxy-base-urls.zip && \
    jupyter labextension install jupyterlab-server-proxy

COPY omero.sh /usr/local/bin/omero
COPY \
    initialise.sh \
    jupyter_notebook_config.py \
    omero-logomark.svg \
    omero-web-proxy.sh \
    omeroweb-5.4.9.patch \
    /home/jovyan/
RUN mv jupyter_notebook_config.py omero-logomark.svg /home/jovyan/.jupyter/ && \
    cd /opt/omero/server/OMERO.server/lib/python && \
    patch -p0 < ~/omeroweb-5.4.9.patch && \
    omero config append omero.web.middleware '{"index": 0, "class": "whitenoise.middleware.WhiteNoiseMiddleware"}'

ENV JUPYTER_ENABLE_LAB=1
