HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

setopt extended_history inc_append_history share_history
setopt hist_ignore_all_dups hist_ignore_space hist_reduce_blanks hist_verify
setopt auto_cd auto_pushd pushd_ignore_dups extended_glob interactive_comments
setopt no_beep no_flow_control

zsh_plugins=(
  zsh-completions
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

typeset -U fpath
for _plugin in $zsh_plugins; do
  if [[ -d "$ZDOTDIR/plugins/$_plugin/src" ]]; then
    fpath=("$ZDOTDIR/plugins/$_plugin/src" $fpath)
  elif [[ -d "$ZDOTDIR/plugins/$_plugin" ]]; then
    fpath=("$ZDOTDIR/plugins/$_plugin" $fpath)
  fi
done
unset _plugin

(( $+commands[fd] )) && _fd_bin=fd
(( ! $+commands[fd] && $+commands[fdfind] )) && _fd_bin=fdfind
(( $+commands[bat] )) && _bat_bin=bat
(( ! $+commands[bat] && $+commands[batcat] )) && _bat_bin=batcat

[[ "$_fd_bin" == fdfind ]] && alias fd='fdfind'
[[ "$_bat_bin" == batcat ]] && alias bat='batcat'

if ls --color=auto /dev/null >/dev/null 2>&1; then
  _ls_preview='ls -1 --color=always'
else
  _ls_preview='ls -1G'
fi

zmodload zsh/complist
autoload -Uz compinit
_zcompdump="$XDG_CACHE_HOME/zsh/zcompdump"
[[ -d "${_zcompdump:h}" ]] || mkdir -p "${_zcompdump:h}"
if [[ ! -s "$_zcompdump" || -n "$_zcompdump"(#qN.mh+24) ]]; then
  compinit -d "$_zcompdump"
else
  compinit -C -d "$_zcompdump"
fi
unset _zcompdump

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' completer _complete _match
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:warnings' format '%F{red}-- no matches --%f'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-prompt '%SAt %p: press Tab again or type a character%s'
zstyle ':completion:*' select-prompt '%SCurrent selection: %p%s'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' use-cache on

if (( $+commands[dircolors] )); then
  eval "$(dircolors -b)"
elif (( $+commands[gdircolors] )); then
  eval "$(gdircolors -b)"
fi
if [[ -n "$LS_COLORS" ]]; then
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
else
  zstyle ':completion:*' list-colors ''
fi

autoload -Uz vcs_info colors && colors
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats ' %F{magenta}%b%f%F{red}%u%c%f'
zstyle ':vcs_info:git:*' actionformats ' %F{magenta}%b%f %F{yellow}(%a)%f%F{red}%u%c%f'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'
precmd() { vcs_info }

setopt prompt_subst
PROMPT='%F{cyan}%~%f${vcs_info_msg_0_} %(?.%F{green}.%F{red})%(!.#.❯)%f '
RPROMPT='%(?..%F{red}%?%f)'

bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
[[ -n "${terminfo[khome]}" ]] && bindkey "${terminfo[khome]}" beginning-of-line
[[ -n "${terminfo[kend]}" ]] && bindkey "${terminfo[kend]}" end-of-line
[[ -n "${terminfo[kdch1]}" ]] && bindkey "${terminfo[kdch1]}" delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

if (( $+commands[fzf] )) && [[ -t 0 && -t 1 ]]; then
  if [[ -n "$_fd_bin" ]]; then
    export FZF_DEFAULT_COMMAND="$_fd_bin --type f --hidden --follow --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$_fd_bin --type d --hidden --follow --exclude .git"
  fi
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
  export FZF_CTRL_R_OPTS='--exact'

  if fzf --zsh </dev/null >/dev/null 2>&1; then
    source <(fzf --zsh)
  else
    for _file in \
      /usr/share/doc/fzf/examples/key-bindings.zsh \
      /usr/share/doc/fzf/examples/completion.zsh \
      /usr/share/fzf/key-bindings.zsh \
      /usr/share/fzf/completion.zsh \
      /opt/homebrew/opt/fzf/shell/key-bindings.zsh \
      /opt/homebrew/opt/fzf/shell/completion.zsh
    do
      [[ -r "$_file" ]] && source "$_file"
    done
    unset _file
  fi
fi

if [[ -n "$_bat_bin" ]]; then
  export BAT_THEME="${BAT_THEME:-ansi}"
  export MANPAGER="sh -c 'col -bx | $_bat_bin --language man --style plain'"
  export MANROFFOPT='-c'
fi

(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

if [[ -o zle ]]; then
  ZSH_AUTOSUGGEST_STRATEGY=(history)
  for _plugin in $zsh_plugins; do
    for _entry in \
      "$ZDOTDIR/plugins/$_plugin/$_plugin.plugin.zsh" \
      "$ZDOTDIR/plugins/$_plugin/$_plugin.zsh"
    do
      [[ -r "$_entry" ]] && source "$_entry" && break
    done
  done
  unset _plugin _entry
fi

(( $+widgets[fzf-tab-complete] )) && zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --height=60% --border
if [[ -n "$_bat_bin" ]]; then
  zstyle ':fzf-tab:complete:*:*' fzf-preview \
    "[[ -d \$realpath ]] && $_ls_preview \$realpath || $_bat_bin --color=always --style=numbers --line-range=:200 \$realpath 2>/dev/null"
fi
zstyle ':fzf-tab:complete:cd:*' fzf-preview "$_ls_preview \$realpath"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "$_ls_preview \$realpath"
unset _fd_bin _bat_bin _ls_preview

for _file in aliases functions; do
  [[ -r "$ZDOTDIR/$_file.zsh" ]] && source "$ZDOTDIR/$_file.zsh"
done
unset _file

[[ -r "$ZDOTDIR/local.zshrc" ]] && source "$ZDOTDIR/local.zshrc"
[[ -n "$NVM_DIR" && -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
