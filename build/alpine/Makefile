all: sshd gitd
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
