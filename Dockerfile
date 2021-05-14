# FROM rocker/binder:3.4.2
FROM rocker/geospatial:4.0.2

# Copy repo into ${HOME}, make user own $HOME
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
