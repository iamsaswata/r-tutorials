# add r and python geospatial tools
FROM mstrimas/tidyverse

MAINTAINER "Matt Strimas-Mackey" mes335@cornell.edu
LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# install spatial packages, from https://hub.docker.com/r/rocker/geospatial/dockerfile
RUN apt-get update \
  # connect to ubuntugis/ubuntugis-unstable to get latest versions of spatial libraries
  && add-apt-repository ppa:ubuntugis/ubuntugis-unstable -y \
  && apt-get install -y \
    lbzip2 \
    libfftw3-dev \
    libgeos-dev \
    libgdal-dev \
    libgsl0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libjq-dev \
    libmysqlclient-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libnetcdf-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev \
    netcdf-bin \
    postgis \
    protobuf-compiler \
    sqlite3 \
    tk-dev \
    unixodbc-dev
    
# gdal binaries, including python bindings
RUN apt-get update \
  && apt-get install -y gdal-bin python3-dev python3-pip python3-numpy python3-gdal \
  && git clone https://github.com/mstrimas/gdal-summarize.git \
  && mv gdal-summarize/gdal-summarize.py /usr/bin/ \
  && rm -rf gdal-summarize/
  
# tippecanoe for map tiles
RUN git clone https://github.com/mapbox/tippecanoe.git \
  && cd tippecanoe \
  && make -j \
  && make install \
  && cd .. \
  && rm -rf tippecanoe
  
# install spatial packages, from https://hub.docker.com/r/rocker/geospatial/dockerfile
RUN  r -e 'install.packages(c("rgdal", "sf", "lwgeom"), repos = "https://cloud.r-project.org", type = "source")' \
  && install.r \
    RandomFields \
    RNetCDF \
    countrycode \
    classInt \
    fasterize \
    geofacet \
    gstat \
    hdf5r \
    janitor \
    landscapemetrics \
    mapproj \
    ncdf4 ncmeta tidync RNetCDF \
    proj4 \
    raster \
    rasterVis \
    rgeos \
    rnaturalearth rnaturalearthdata \
    sp \
    stars \
    spacetime \
    spatstat \
    spdep \
    terra \
    geoR \
    geosphere

RUN installGithub.r ropensci/rnaturalearthhires

# fix proj issue on singularity  
RUN echo 'PROJ_LIB=/usr/share/proj/' >> /usr/lib/R/etc/Renviron

# get things working on bridges2
RUN mkdir /jet && mkdir /ocean
  
WORKDIR /home/docker/

CMD ["/start.sh"]
