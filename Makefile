
LOCAL_IMAGE_ARMHF=build/crossbuild-arm:latest
LOCAL_IMAGE_AARCH64=build/crossbuild-aarch64:latest

build: build/armhf build/aarch64

build/armhf:
	@docker build armhf/ -f armhf/Dockerfile -t $(LOCAL_IMAGE_ARMHF)

build/aarch64:
	@docker build aarch64/ -f aarch64/Dockerfile -t $(LOCAL_IMAGE_AARCH64)

login:
	@docker login

logout:
	@docker logout

push: push/armhf push/aarch64

push/armhf:
	@docker tag $(LOCAL_IMAGE_ARMHF) elfabio972/crossbuilder:armhf
	@docker push elfabio972/crossbuilder:armhf

push/aarch64:
	@docker tag $(LOCAL_IMAGE_AARCH64) elfabio972/crossbuilder:aarch64
	@docker push elfabio972/crossbuilder:aarch64

demo: demo/armhf demo/aarch64

demo/armhf:
	@docker build test/ -f test/Dockerfile-armhf

demo/aarch64:
	@docker build test/ -f test/Dockerfile-aarch64
