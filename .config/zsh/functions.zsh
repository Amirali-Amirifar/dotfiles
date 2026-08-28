take() {
  [[ -n "$1" ]] || { print -u2 'usage: take <dir>'; return 2 }
  mkdir -p -- "$1" && cd -- "$1"
}
