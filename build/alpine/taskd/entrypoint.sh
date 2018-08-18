#! /bin/sh -eu

function init() {
  test -d /tasks
  test -r /pki/ca.cert.pem
  test -r /pki/client.cert.pem
  test -r /pki/client.key.pem
  test -r /pki/server.cert.pem
  test -r /pki/server.crl.pem
  test -r /pki/server.key.pem

  cd /tasks
  taskd init

  taskd config --force ca.cert     /pki/ca.cert.pem
  taskd config --force client.cert /pki/client.cert.pem
  taskd config --force client.key  /pki/client.key.pem
  taskd config --force server.cert /pki/server.cert.pem
  taskd config --force server.crl  /pki/server.crl.pem
  taskd config --force server.key  /pki/server.key.pem

  taskd config --force pid.file /tasks/taskd.pid
  taskd config --force server 0.0.0.0:53589

  taskd config --force log /dev/stdout
}

if ! test -e /tasks/config; then
  ( init )
fi

if [ $# -gt 0 ];then
  exec "$@"
else
  exec taskd server
fi
