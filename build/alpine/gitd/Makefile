export HUB_USER ?= ${USER}
build:
	docker build --rm --build-arg HUB_USER=${HUB_USER} --target gitd -t ${HUB_USER}/gitd-alpine .
	docker build --rm --build-arg HUB_USER=${HUB_USER}               -t ${HUB_USER}/gitd-alpine-onbuild .
.PHONY: build

push:
	docker push vitaly/gitd
.PHONY: push
