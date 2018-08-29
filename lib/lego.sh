lego_root() {
  echo "$(cd "$(dirname "${BASH_SOURCE[0]}")"/..; pwd)"
}

source "$(lego_root)/lib/colors.sh"

usage() {
  help
  exit 1
}

die() {
  echo "$@"
  exit 1
}

handle_help() {
  [ $# -gt 0 ] || return 0

  case "$1" in
    -h|--help|help) help; exit;;
  esac
}

require_args() {
  local name="$1"; shift
  local n="$1"; shift

  [ $# -lt $n ] || return 0

  echo "$name: required arguments: $n"
  usage
}

initialized() {
  test -r .legos
}

check_initialized() {
  initialized || die "run 'lego init' first"
}

src_lego() {
  local src="$(lego_root)/lib/lego/$1"
  [ -d "$src" ] || die "$src/ not found"
  echo "$src"
}

dst_lego() {
  [ 1 = $# ] || die "dst_lego requires one argument"
  check_initialized
  echo "$(pwd)/$1"
}
