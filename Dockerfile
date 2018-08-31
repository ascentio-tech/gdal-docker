FROM debian:sid-20180716

RUN echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/01proxy
RUN apt-get update \
  && apt-get install --no-install-recommends -y \
     gdal-bin python-gdal python3-gdal \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/apt/apt.conf.d/01proxy

CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
