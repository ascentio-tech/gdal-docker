IMAGE=ascentiotech/gdal

test-image:
	docker run --rm -it ${IMAGE}

include inc/docker.mk
