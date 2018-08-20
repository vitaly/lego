lego_root() {
  "$(cd "$(dirname "${BASH_SOURCE[0]}")"/..; pwd)"
}

usage() {
  help
  exit 1
}

handle_help() {
  [ $# -gt 0 ] || return 0

  case "$1" in
    -h|--help|help) help; exit;;
  esac
}

require_args() {
  [ $# -gt 0 ] || usage
}

initialized() {
  test -d legos
}
