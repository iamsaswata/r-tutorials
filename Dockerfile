FROM rocker/geospatial:latest
MAINTAINER "SNANDI" e.h.snandi@iitb.ac.in

RUN install2.r --error --skipinstalled \
        terra 
