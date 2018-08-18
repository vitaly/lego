build:
	docker build --rm --target sshd -t sshd-alpine .
	docker build --rm               -t sshd-alpine-onbuild .
.PHONY: build

push:
	docker push vitaly/sshd
.PHONY: push
