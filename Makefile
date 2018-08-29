#
# author: Franco Riberi
#

HTTP_PROXY=
build:
	docker build --build-arg http_proxy=${HTTP_PROXY} -t plamedma/gdal-trusty .
