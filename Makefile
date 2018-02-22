
TARGET ?= armhf
ARCHS ?= aarch64 armhf

build: $(TARGET)/Dockerfile
	@docker build $(BUILD_OPTS) $(TARGET)/ -f $(TARGET)/Dockerfile -t $(REPO):$(TARGET)

push:
	@docker push $(REPO):$(TARGET)

test:
	@docker build $(BUILD_OPTS) samples/ -f samples/Dockerfile-$(TARGET)

login:
	@docker login -u="$(DOCKER_USERNAME)" -p="$(DOCKER_PASSWORD)"

logout:
	@docker logout