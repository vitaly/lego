export HUB_USER ?= ${USER}
build:
	docker build --rm --target sshd -t ${HUB_USER}/sshd-alpine .
	docker build --rm               -t ${HUB_USER}/sshd-alpine-onbuild .
.PHONY: build

push:
	docker push vitaly/sshd
.PHONY: push
