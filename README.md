# Docker Gdal Base Image

This is a docker base image for the Plamedma project. Based on Ubuntu 14.04 Trusty and Gdal 2.1.3.

## Install Docker
* [Official Docker Page](https://www.docker.com/)

* [Install Docker on Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntu/)

* [How run docker without sudo](http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo)

* [Docker Volume](https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-directory-as-a-data-volume)

* You can use [asc-devkit](https://gitlab.ascentio.com.ar/DEV/asc-devkit) to install docker

## Generate the image called gdal-trusty

```sh
   make build
```

### Using a caching proxy to improve image build times
1. Use [squid-cache](https://gitlab.ascentio.com.ar/DEV/squid-cache)
2. `make build HTTP_PROXY=http://172.17.0.1:3128`
