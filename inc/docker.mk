HTTP_PROXY=
HTTPS_PROXY=
BUILD_OPTS=

pre-build-image:

pull-images:

build-image: pull-images pre-build-image
	docker build ${BUILD_OPTS} --build-arg https_proxy=${HTTPS_PROXY} --build-arg http_proxy=${HTTP_PROXY} --tag ${IMAGE}:${IMAGE_TAG} .
build-image-with-local-cache: pull-images pre-build-image
	$(MAKE) build-image HTTP_PROXY=http://172.17.0.1:3128 HTTPS_PROXY=http://172.17.0.1:3128
IMAGE_TAG=latest
push-image: build-image
	docker push ${IMAGE}:${IMAGE_TAG}

lint-image:
	@echo 'More about Hadolint rules: https://github.com/hadolint/hadolint#rules'
	@echo 'RUN instructions are analyzed with Shellcheck: https://github.com/koalaman/shellcheck/wiki'
	@echo 'Bulding images best practices: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#sort-multi-line-arguments'
	docker run --rm -i hadolint/hadolint < Dockerfile

