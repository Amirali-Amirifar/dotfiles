case "$OSTYPE" in
  darwin*)
    for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
      [[ -x "$brew" ]] && eval "$("$brew" shellenv)" && break
    done
    ;;
esac
