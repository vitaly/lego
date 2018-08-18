#!/bin/bash -eu

d="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"
cd $d

RESET=$(   echo -e '\033[0m'  )

BOLD=$(    echo -e '\033[1m'  )

BLACK=$(   echo -e '\033[30m' )
RED=$(     echo -e '\033[31m' )
GREEN=$(   echo -e '\033[32m' )
YELLOW=$(  echo -e '\033[33m' )
BLUE=$(    echo -e '\033[34m' )
MAGENTA=$( echo -e '\033[35m' )
CYAN=$(    echo -e '\033[36m' )
WHITE=$(   echo -e '\033[37m' )

generate_pki() {
  cat << END
##############################################################################
${RED}TASKD requires certificates for operation.${RESET}


Press ${BOLD}Ctrl-C${RESET} to stop.
You will then ${RED}have to generate the certificates yourself${RESET},
place them in the ${BLUE}build/fs/pki${RESET} directory, and run '${BLUE}lego update${RESET}'

Press ${BOLD}ENTER${RESET} edit certifiate generation variables.${RESET}
END

  read

  set -x

  if [ ! -e vars ]; then
    cp templates/vars vars
  fi
  $EDITOR vars

  ## prepare config image
  mkdir -p build/fs/usr/share/taskd/pki/
  cp vars build/fs/usr/share/taskd/pki/
  docker build --rm -t taskd-config build
  rm -rf build/fs/usr/share/taskd/pki
  # allow to fail in case there are user supplied files in build/fs
  rmdir build/fs/usr/share/taskd || true
  rmdir build/fs/usr/share || true
  rmdir build/fs/usr || true

  ## generate certificates
  docker container rm taskd-config || true
  docker run -ti --name taskd-config -w /usr/share/taskd/pki/ taskd-config  ./generate

  ## extract certificates
  rm -rf build/pki
  docker cp taskd-config:/usr/share/taskd/pki build/pki
  mkdir -p build/fs/pki
  mv build/pki/*.pem build/fs/pki/


  ## cleanup
  docker rm taskd-config
  docker image rm taskd-config
  rm -rf build/pki
}


if [ ! -d build/fs/pki ]; then
  generate_pki
fi
