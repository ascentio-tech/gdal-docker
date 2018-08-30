HTTP_PROXY=
HTTPS_PROXY=
BUILD_OPTS=

pre-build-image:

pull-images:

build-image: pull-images pre-build-image
	docker build ${BUILD_OPTS} --build-arg https_proxy=${HTTPS_PROXY} --build-arg http_proxy=${HTTP_PROXY} --tag ${IMAGE}:latest .
build-image-with-local-cache: pull-images pre-build-image
	$(MAKE) build-image HTTP_PROXY=http://172.17.0.1:3128 HTTPS_PROXY=http://172.17.0.1:3128
push-image: build-image
	docker tag ${IMAGE}:latest ${INTERNAL_REGISTRY_URL}/${IMAGE}:latest
	docker push ${INTERNAL_REGISTRY_URL}/${IMAGE}:latest

lint-image:
	@echo 'More about Hadolint rules: https://github.com/hadolint/hadolint#rules'
	@echo 'RUN instructions are analyzed with Shellcheck: https://github.com/koalaman/shellcheck/wiki'
	@echo 'Bulding images best practices: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#sort-multi-line-arguments'
	docker run --rm -i hadolint/hadolint < Dockerfile

