#!/bin/bash -eu

d="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"

find_keys() {
  ls ~/.ssh/*.pub || true
}

ok() {
  read a
  [[ "$a" == 'y' || "$a" == "Y" || "$a" == ""  ]]
}

authorized_keys() {
  local ak="$d/build/authorized_keys/root"
  if [ ! -e "$ak" ]; then
    echo -n "setup authorized_keys for root? "
    if ok; then
      echo
      for f in $(find_keys); do
        echo -n "use $f (Y/n) "
        if ok; then cat "$f" >> "$ak"; fi
      done
    else
      touch "$ak"
      echo -e "please add yiour keys to $ak\n"
    fi
  fi

  echo

  ak="$d/build/authorized_keys/git"
  if [ ! -e "$ak" ]; then
    echo -n "setup authorized_keys for git? "
    if ok; then
      echo
      for f in $(find_keys); do
        echo -n "use $f (Y/n) "
        if ok; then cat "$f" >> "$ak"; fi
      done
    else
      touch "$ak"
      echo -e "please add yiour keys to $ak\n"
    fi
  fi
}

host_keys() {
  if [ ! -d "$d/build/fs/etc/ssh" ]; then
    cat <<END
We can pre-generate sshd host keys, so that your run a new container
END
echo -n "Generate? (Y/n)"

    if ok; then
      mkdir -p "$d/build/fs/etc/ssh"
      ssh-keygen -A -f "$d/build/fs"

    fi
  fi
}

authorized_keys
host_keys
