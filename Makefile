
TARGET ?= armhf
ARCHS ?= aarch64 armhf

build: $(TARGET)/Dockerfile
	@docker build $(BUILD_OPTS) $(TARGET)/ -f $(TARGET)/Dockerfile -t build/crossbuild:$(TARGET)-latest

login:
	@docker login

logout:
	@docker logout

push: push/armhf push/aarch64

push/armhf:
	@docker tag build/crossbuild:$(TARGET)-latest elfabio972/crossbuilder:armhf
	@docker push elfabio972/crossbuilder:armhf

push/aarch64:
	@docker tag build/crossbuild:$(TARGET)-latest elfabio972/crossbuilder:aarch64
	@docker push elfabio972/crossbuilder:aarch64

demo: demo/armhf demo/aarch64

demo/armhf:
	@docker build test/ -f test/Dockerfile-armhf

demo/aarch64:
	@docker build test/ -f test/Dockerfile-aarch64
