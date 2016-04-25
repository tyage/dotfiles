# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wedisagree"

plugins=(alias mac git brew gem github ruby rbenv)

source $ZSH/oh-my-zsh.sh

# path
export PATH=/usr/texbin:/usr/local/opt/rbenv/shims:$HOME/.rbenv/shims:$HOME/.phpenv/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

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

  # original: http://rcmdnk.github.io/blog/2014/09/01/computer-mac-homebrew/
  function cask-upgrade() {
    caskroom="/opt/homebrew-cask/Caskroom"
    apps=($(brew cask list))
    for a in ${apps[@]};do
      info=$(brew cask info $a)
      if echo "$info"| grep -q "Not installed";then
        echo -n "want to upgrade $a ? [Y/n]: "
        read ANSWER
        case $ANSWER in
          "Y" | "Yes" | "y" | "yes" )
            brew cask install $a
            info=$(brew cask info $a)
            current=$(echo "$info"|grep "${caskroom}/${a}"|cut -d' ' -f1)
            for dir in $(ls ${caskroom}/${a});do
              testdir="${caskroom}/${a}/${dir}"
              if [ "$testdir" != "$current" ];then
                rm -rf "$testdir"
              fi
            done
          ;;
        esac
      fi
    done
  }

  # alias
  alias ls="ls -G"

  # Install apps in /Applications with homebrew cask
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  ;;
# GNU
linux*)
  # alias
  alias ls="ls --color=auto --show-control-chars"
  alias pbcopy="xsel --clipboard --input"
  alias pbpaste="xsel --clipboard --output"
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
if [ -x "`which phpenv`" ]; then
  eval $(phpenv init -)
fi
