all: sshd gitd taskd gemstash npm-proxy
.PHONY: all

base:
	${MAKE} -C $@
.PHONY: base

sshd: base
	${MAKE} -C $@
.PHONY: sshd

gitd: sshd
	${MAKE} -C $@
.PHONY: gitd

taskd: base
	${MAKE} -C $@
.PHONY: taskd

gemstash:
	${MAKE} -C $@
.PHONY: gemstash

npm-proxy:
	${MAKE} -C $@
.PHONY: npm-proxy
