# lang
export LANG=ja_JP.UTF-8

local uname=`uname`

# OS X
if [ $uname = "Darwin" ]; then
  export PATH=/usr/local/bin:$PATH
  export PGDATA=/usr/local/var/postgres

  # https://langui.sh/2014/03/10/wunused-command-line-argument-hard-error-in-future-is-a-harsh-mistress/
  export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"

  # IME in XQuartz
  GTK_IM_MODULE=uim; export GTK_IM_MODULE
  XMODIFIERS="@im=uim"; export XMODIFIERS
fi

# color
if [ -x `which dircolors` ]; then
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
alias ls="ls --color"
alias ll="ls -alF"
alias g="git"
alias tmux="tmux -2"

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

