# Base image: Ubuntu 14.04 Trusty Tahyr
FROM ubuntu:trusty
MAINTAINER Franco Riberi <friberi@ascentio.com.ar>

# Load assets
ENV ROOTDIR /usr/local/
ENV GDAL_VERSION 2.1.3

WORKDIR $ROOTDIR

RUN echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/01proxy

# Install basic dependencies
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
      curl \
      software-properties-common \
      python-software-properties \
      build-essential \
      python-dev \
      python-numpy \
      libspatialite-dev \
      sqlite3 \
      libpq-dev \
      libcurl4-gnutls-dev \
      libproj-dev \
      libxml2-dev \
      libgeos-dev \
      libnetcdf-dev \
      libpoppler-dev \
      libspatialite-dev \
      libhdf4-alt-dev \
      libhdf5-serial-dev \
    && cd src \
    && curl -OSL http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz \
    && mkdir /usr/local/src/gdal-${GDAL_VERSION} \
    && tar -xC /usr/local/src -f /usr/local/src/gdal-${GDAL_VERSION}.tar.gz \
    && cd gdal-${GDAL_VERSION} \
    && ./configure --with-python --with-hdf5 --with-geos=yes \
    && make \
    && make install \
    && ldconfig \
    && rm -rf /usr/share/doc/* \
    && rm -Rf $ROOTDIR/src/* \
    && apt-get purge -y \
      curl \
      python-dev \
      libspatialite-dev \
      libcurl4-gnutls-dev \
      libpoppler-dev \
      libspatialite-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
