export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

[[ -f "$XDG_CONFIG_HOME/ripgrep/config" ]] \
  && export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

typeset -U path PATH
path=("$HOME/.local/bin" "$HOME/bin" $path)
export PATH

[[ -r "$ZDOTDIR/local.zsh" ]] && source "$ZDOTDIR/local.zsh"
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
