# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wedisagree"

plugins=(alias mac git brew gem github ruby rbenv)

source $ZSH/oh-my-zsh.sh

# path
export PATH=/usr/texbin:/usr/local/opt/rbenv/shims:$HOME/.rbenv/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# lang
export LANG=en_US.UTF-8

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
  alias ls="ls -G"

  # java home
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)

  # android home
  export ANDROID_HOME=/usr/local/opt/android-sdk
  ;;
# GNU
linux*)
  # alias
  alias ls="ls --color=auto --show-control-chars"
  ;;
esac

# perl
if [ -x "$HOME/perl5" ]; then
  PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
fi

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
alias javac="javac -J-Dfile.encoding=UTF8"

# local zshrc
if [ -f "$HOME/.zshrc-local" ]; then
  source "$HOME/.zshrc-local"
fi

