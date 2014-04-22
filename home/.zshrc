# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wedisagree"

plugins=(git brew gem github ruby rbenv alias mac)

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

# editor
export EDITOR=vim

# alias
alias g="git"
alias tmux="tmux -2"
alias less='less --tabs=4'
