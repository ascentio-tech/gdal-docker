FROM ubuntu:bionic-20180821

ENV ROOTDIR /usr/local/
WORKDIR $ROOTDIR/src
RUN echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/01proxy
ARG GDAL_VERSION=2.3.1
RUN apt-get update \
  && apt-get install --no-install-recommends -y \
     python3 python3-dev python3-pip build-essential \
     wget software-properties-common \
  && pip3 install --no-cache setuptools==40.2.0 \
  && wget https://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz \
  && tar zxvf gdal-${GDAL_VERSION}.tar.gz \
  && cd gdal-${GDAL_VERSION}/ \
  && ./configure --prefix=/usr/ --with-python --with-hdf5 --with-geos=yes \
  && make -j 8 \
  && make install \
  && cd swig/python/ \
  && python3 setup.py install \
  && rm -rf /usr/share/doc/* \
    && rm -Rf /build/* \
    && apt-get purge -y \
      wget \
      python3-dev \
      build-essential \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/* \
      /etc/apt/apt.conf.d/01proxy \
      ${ROOTDIR}

CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
