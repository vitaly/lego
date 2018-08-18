#! /bin/sh -eux

if [ $# -gt 0 ];then
  exec "$@"
fi

function init() {
  test -d /tasks
  test -d /pki

  cd /tasks
  taskd init

  cp -R /pki pki

  test -r pki/ca.cert.pem
  test -r pki/client.cert.pem
  test -r pki/client.key.pem
  test -r pki/server.cert.pem
  test -r pki/server.crl.pem
  test -r pki/server.key.pem
  taskd config --force ca.cert     /tasks/pki/ca.cert.pem
  taskd config --force client.cert /tasks/pki/client.cert.pem
  taskd config --force client.key  /tasks/pki/client.key.pem
  taskd config --force server.cert /tasks/pki/server.cert.pem
  taskd config --force server.crl  /tasks/pki/server.crl.pem
  taskd config --force server.key  /tasks/pki/server.key.pem

  taskd config --force pid.file /tasks/taskd.pid
  taskd config --force server 0.0.0.0:53589

  taskd config --force log /dev/stdout
}

if ! test -e /tasks/config; then
  ( init )
fi

exec taskd server
