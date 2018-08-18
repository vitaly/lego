build:
	docker build --rm --target gitd -t gitd-alpine .
	docker build --rm               -t gitd-alpine-onbuild .
.PHONY: build

push:
	docker push vitaly/gitd
.PHONY: push
