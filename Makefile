
TAG ?= armhf
ARCHS ?= aarch64 armhf

build: $(TAG)/Dockerfile
	@docker build $(BUILD_OPTS) $(TAG)/ -f $(TAG)/Dockerfile -t $(REPO):$(TAG)$(VARIANT)

save:
	@docker save --output .cache/$(TAG).tar $(REPO):$(TAG)$(VARIANT)

push:
	@docker pull $(REPO):$(TAG)$(VARIANT)

pull:
	@docker pull $(REPO):$(TAG)$(VARIANT)

test:
	@docker build $(BUILD_OPTS) samples/ -f samples/Dockerfile-$(TAG)

login:
	@docker login -u="$(DOCKER_USERNAME)" -p="$(DOCKER_PASSWORD)"

logout:
	@docker logout