HTTP_PROXY = http://proxy.uni-leipzig.de:3128
HTTPS_PROXY = http://proxy.uni-leipzig.de:3128
IMAGE_NAME = ubleipzig/shibboleth

.PHONY: 2.6

2.6:
	docker build --pull \
		--build-arg HTTP_PROXY=$(HTTP_PROXY) \
		--build-arg HTTPS_PROXY=$(HTTPS_PROXY) \
		--build-arg NO_PROXY=$(NO_PROXY) \
		--build-arg http_proxy=$(HTTP_PROXY) \
		--build-arg https_proxy=$(HTTPS_PROXY) \
		--build-arg no_proxy=$(NO_PROXY) \
		-t $(IMAGE_NAME):2.6 \
		2.6