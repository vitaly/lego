all: sshd gitd taskd gemstash
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

gemstash: base
	${MAKE} -C $@
.PHONY: gemstash
