# Copyright (c) 2017 Ascentio Technologies S.A. All rights reserved.
#
# This program is confidential and proprietary to Ascentio Technologies S.A.,
# and may not be copied, reproduced, modified, disclosed to
# others, published or used, in whole or in part, without the
# express prior written permission of Ascentio Technologies S.A.
#

# Base image: Ubuntu 14.04 Trusty Tahyr
FROM ubuntu:trusty
MAINTAINER Franco Riberi <friberi@ascentio.com.ar>


# Load assets
ENV ROOTDIR /usr/local/
ENV GDAL_VERSION 2.1.3

WORKDIR $ROOTDIR

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
    && apt-get update -y \
    && apt-get remove -y --purge build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc/* \
    && rm -Rf $ROOTDIR/src/* \
    && apt-get purge -y \
      curl \
      python-dev \
      libspatialite-dev \
      libcurl4-gnutls-dev \
      libproj-dev \
      libgeos-dev \
      libpoppler-dev \
      libspatialite-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y
