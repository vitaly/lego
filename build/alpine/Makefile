all: sshd gitd
.PHONY: all

sshd:
	${MAKE} -C $@
.PHONY: sshd

gitd: sshd
	${MAKE} -C $@
.PHONY: gitd
