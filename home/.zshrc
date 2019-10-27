# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="muse"

plugins=(common-aliases git gem github ruby rbenv)

# plugins for each os
case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
  plugins=($plugins osx)
  ;;
esac

source $ZSH/oh-my-zsh.sh

# auto-suggestions
source $HOME/.homesick/repos/dotfiles/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh

# call compinit to make shell faster
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# path
export PATH=/usr/texbin:/usr/local/opt/rbenv/shims:$HOME/.rbenv/shims:$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:/opt/brew/bin:$PATH

# lang
export LANG=en_US.UTF-8

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

# peco select history
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | \
    eval $tac | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
if [ -x "`which peco`" ]; then
  zle -N peco-select-history
  bindkey '^r' peco-select-history
fi

# phpenv
export PATH=$PATH:$HOME/.phpenv/bin
if [ -x "`which phpenv`" ]; then
  eval "$(phpenv init -)"
fi

# set GPG TTY
export GPG_TTY=$(tty)

# overwrite ghq function to execute just cd on `ghq look`
ghq () {
  if [ "$1" = look -a -n "$2" ]; then
    cd $(command ghq list -e -p $2)
    return
 fi

  command ghq "$@"
}
# search ghq in peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# zshrc for each os
case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
  source "$HOME/.zshrc-darwin"
  ;;
# GNU
linux*)
  source "$HOME/.zshrc-linux"
  ;;
esac

# local zshrc
if [ -f "$HOME/.zshrc-local" ]; then
  source "$HOME/.zshrc-local"
fi
