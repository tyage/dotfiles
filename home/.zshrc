# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# lang
export LANG=ja_JP.UTF-8

case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
  export PGDATA=/usr/local/var/postgres

  # https://langui.sh/2014/03/10/wunused-command-line-argument-hard-error-in-future-is-a-harsh-mistress/
  export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"

  # IME in XQuartz
  GTK_IM_MODULE=uim; export GTK_IM_MODULE
  XMODIFIERS="@im=uim"; export XMODIFIERS

  # alias
  alias ls="ls -G";
  ;;
# GNU
linx*)
  # alias
  alias ls="ls --color=auto";
  ;;
esac

# color
if [ -x "`which dircolors`" ]; then
  eval "$(dircolors -b)"
fi

# auto complete
if [ -d /usr/local/share/zsh/site-functions ]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
autoload -Uz zmv
autoload -U compinit
compinit -u

# editor
export EDITOR=vim

# alias
alias ll="ls -alF"
alias g="git"
alias tmux="tmux -2"
alias less='less --tabs=4'

# rbenv
if [ -d $HOME/.rbenv/ ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# sbt
if [ -d /usr/local/sbt ]; then
  export SBT_HOME=/usr/local/sbt
  export PATH=$PATH:$SBT_HOME/bin
fi

