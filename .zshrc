# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify inc_append_history share_history
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
alias \?='echo $USER@`hostname`:$PWD'
alias d='docker'
alias l='ls'
alias la='ls -A'
alias lla='ll -A'
alias v='vim'
alias g='git'
alias tmux='tmux -u'
alias trl='tree|less'
alias grep='grep --color=auto'

reset="%{${reset_color}%}"
white="%{$fg[white]%}"
gray="%{$fg_bold[black]%}"
green="%{$fg_bold[green]%}"
red="%{$fg[red]%}"
yellow="%{$fg[yellow]%}"

#export PROMPT="%n${red}@${reset}%m:${yellow}%c${reset}%# "
export PROMPT="${green}%#${reset} "
export EDITOR=vim

export TERM="screen-256color"

if [[ $(uname) != "Darwin" ]]; then
  LC_ALL=fi_FI.utf8
  LC_CTYPE=fi_FI.utf8
else
  LC_ALL=fi_FI.UTF-8
  LC_CTYPE=fi_FI.UTF-8
  xset r rate 150 40
fi

w () { find . -name "*$1*" }

ssh2() {
  local color=$1
  shift
  sh -c "ssh $@ -t \"export PS1='\[\e[4${color};37m\][\t/\u@\h]\[\e[0;37m\]>\[\e[0m\] ';sh\""
}
qa () {
  if [ $# -ne 1 ]; then
    echo "Usage: qa <host>";
  else
    ssh2 5 "qa-$1"
  fi
}

dev () {
  if [ $# -ne 1 ]; then
    echo "Usage: dev <host>";
  else
    ssh2 4 "dev-$1"
  fi
}

prod () {
  if [ $# -ne 1 ]; then
    echo "Usage: prod <host>";
  else
    ssh2 1 "prod-$1"
  fi
}

PATH="$HOME/bin:./node_modules/.bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
