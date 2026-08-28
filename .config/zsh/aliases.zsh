if (( $+commands[eza] )); then
  alias ls='eza --color=auto --group-directories-first'
  alias ll='eza -lah --group-directories-first'
  alias la='eza -a --group-directories-first'
  alias l='eza -F --group-directories-first'
elif ls --color=auto /dev/null >/dev/null 2>&1; then
  alias ls='ls --color=auto --group-directories-first'
  alias ll='ls -lah'
  alias la='ls -A'
  alias l='ls -CF'
else
  alias ls='ls -G'
  alias ll='ls -lah'
  alias la='ls -A'
  alias l='ls -CFG'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias mkdir='mkdir -p'

if command grep --help 2>&1 | command grep -q -- '--color'; then
  alias grep='grep --color=auto'
  alias egrep='grep -E --color=auto'
  alias fgrep='grep -F --color=auto'
fi
alias df='df -h'
alias du='du -h'
(( $+commands[free] )) && alias free='free -h'
(( $+commands[ip] )) && alias ip='ip -color=auto'

alias v='nvim'
alias vim='nvim'
alias rga='rg --no-ignore --hidden'
alias rgf='rg --files'
alias rgl='rg --files-with-matches'
alias catp='bat --style=plain'
alias batl='bat --paging=always'

if (( $+commands[fzf] && ($+commands[bat] || $+commands[batcat]) )); then
  alias ff='fzf --preview "${commands[bat]:-batcat} --color=always --style=numbers {}"'
elif (( $+commands[fzf] )); then
  alias ff='fzf --preview "head -100 {}"'
fi

alias g='git'
alias gst='git status'
alias gsh='git show'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias grhh='git reset --hard'
alias gmtl='git mergetool'
alias grbc='git rebase --continue'
