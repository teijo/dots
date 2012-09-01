# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/teijo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U promptinit
promptinit

autoload -U colors && colors

# Fix "git show HEAD^" issue with '^'
unsetopt extendedglob

bindkey '^R' history-incremental-search-backward

if [[ $(uname) != "Darwin" ]]; then
  alias ls='ls -FX --color=auto --group-directories-first'
  alias ll='ls -lhX'
else
  # Light blue dircolor
  export LSCOLORS=Exfxcxdxbxegedabagacad
  alias ls='ls -GF'
  alias ll='ls -lh'
fi
alias l='ls'
alias la='ls -A'
alias lla='ll -A'
alias v='vim'
alias g='git'
alias trl='tree|less'
alias grep='grep --color=auto'

reset="%{${reset_color}%}"
white="%{$fg[white]%}"
gray="%{$fg_bold[black]%}"
green="%{$fg_bold[green]%}"
red="%{$fg[red]%}"
yellow="%{$fg[yellow]%}"

export PROMPT="%n${red}@${reset}%m:${yellow}%c${reset}%# "
