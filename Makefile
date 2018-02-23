
TAG ?= armhf
ARCHS ?= aarch64 armhf

build: $(TAG)/Dockerfile
	@docker build $(BUILD_OPTS) $(TAG)/ -f $(TAG)/Dockerfile -t $(REPO):$(TAG)$(VARIANT)

login:
	@echo "$(DOCKER_PASSWORD)" | docker login -u="$(DOCKER_USERNAME)" --password-stdin

logout:
	@docker logout

pull:
	@docker pull $(REPO):$(TAG)$(VARIANT)

push:
	@docker push $(REPO):$(TAG)$(VARIANT)

save:
	@docker save --output .images/$(TAG)$(VARIANT).tar $(REPO):$(TAG)$(VARIANT)

tag:
	@docker tag $(REPO):$(TAG)$(VARIANT) $(REPO):$(TAG)

test:
	@docker build $(BUILD_OPTS) samples/ -f samples/Dockerfile-$(TAG)
