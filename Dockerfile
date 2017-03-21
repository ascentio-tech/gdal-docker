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

ENV ROOTDIR /usr/local/
ENV GDAL_VERSION 2.1.1

# Load assets
WORKDIR $ROOTDIR/

ADD http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz $ROOTDIR/src/

# Install basic dependencies
RUN apt-get update -y && apt-get install -y \
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
    wget

# Compile and install GDAL
RUN cd src \
    && tar -xvf gdal-${GDAL_VERSION}.tar.gz \
    && cd gdal-${GDAL_VERSION} \
    && ./configure --with-python --with-hdf5 --with-geos=yes \
    && make \
    && make install \
    && ldconfig \
    && apt-get update -y \
    && apt-get remove -y --purge build-essential wget \
    && rm -Rf $ROOTDIR/src/*
