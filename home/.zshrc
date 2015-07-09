# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wedisagree"

plugins=(alias mac git brew gem github ruby rbenv)

source $ZSH/oh-my-zsh.sh

# path
export PATH=/usr/texbin:/usr/local/opt/rbenv/shims:$HOME/.rbenv/shims:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

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

  # http://qiita.com/2k0ri/items/9fe8d33a72dbfb15fe6b
  alias cask-upgrade='for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || { brew cask uninstall $c && brew cask install $c; }; done'

  # alias
  alias ls="ls -G"

  # Install apps in /Applications with homebrew cask
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  ;;
# GNU
linux*)
  # alias
  alias ls="ls --color=auto --show-control-chars"
  ;;
esac

# rbenv plugin is broken
eval "$(rbenv init -)"

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

# neovim
if [ -x "`which nvim`" ]; then
  alias vim="nvim"
fi

# android home
if [ -f "/usr/local/opt/android-sdk" ]; then
  export ANDROID_HOME=/usr/local/opt/android-sdk
fi

# golang
export GOPATH=~/.gopath
export PATH=$GOPATH/bin:$PATH

# bindkey
bindkey -v
bindkey '^R' history-incremental-search-backward

# opam
if [ -x "`which opam`" ]; then
  eval $(opam config env)
fi

