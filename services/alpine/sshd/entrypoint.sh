#!/bin/sh
[ -n "$@" ] && exec "$@"
ssh-keygen -A
exec /usr/sbin/sshd -D -e "$@"
