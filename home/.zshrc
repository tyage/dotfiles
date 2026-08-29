# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="muse"

plugins=(common-aliases git gem github ruby rbenv)

# plugins for each os
case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
  plugins=($plugins macos)
  ;;
esac

source "$ZSH/oh-my-zsh.sh"

# auto-suggestions
autosuggestions="$HOME/.homesick/repos/dotfiles/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -r "$autosuggestions" ]]; then
  source "$autosuggestions"
fi
unset autosuggestions

# path
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.rbenv/shims"
  /opt/homebrew/opt/ruby/bin
  /opt/homebrew/bin
  /usr/local/opt/ruby/bin
  /usr/local/bin
  /usr/local/sbin
  /Library/TeX/texbin
  $path
)
typeset -U path
export PATH

# lang
export LANG=en_US.UTF-8

# perl
if [[ -d "$HOME/perl5" ]]; then
  PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
fi

# color
if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi

# editor and neovim compatibility
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
  alias vim=nvim
else
  export EDITOR=vim
fi

# alias
alias g="git"
alias less='less --tabs=4'
alias javac="javac -J-Dfile.encoding=UTF8"
alias devinit='devcontainer templates apply -t ghcr.io/tyage/devcontainer/default:1 -w .'

# android home
if [[ -d "/usr/local/opt/android-sdk" ]]; then
  export ANDROID_HOME=/usr/local/opt/android-sdk
fi

# golang
export GOPATH="${GOPATH:-$HOME/go}"
path=("$GOPATH/bin" $path)

# bindkey
bindkey -v
bindkey '^R' history-incremental-search-backward

# opam
if command -v opam >/dev/null 2>&1; then
  eval "$(opam env --shell=zsh)"
fi

# peco select history
function peco-select-history() {
  local tac
  if command -v tac >/dev/null 2>&1; then
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
if command -v peco >/dev/null 2>&1; then
  zle -N peco-select-history
  bindkey '^r' peco-select-history
fi

# phpenv
path+=("$HOME/.phpenv/bin")
if command -v phpenv >/dev/null 2>&1; then
  eval "$(phpenv init -)"
fi

# set GPG TTY
if tty >/dev/null 2>&1; then
  export GPG_TTY="$(tty)"
fi

# overwrite ghq function to execute just cd on `ghq look`
ghq () {
  if [[ "${1:-}" == "look" && -n "${2:-}" ]]; then
    local repo
    repo="$(command ghq list -e -p "$2")" || return
    [[ -n "$repo" ]] && cd "$repo"
    return
  fi

  command ghq "$@"
}
# search ghq in peco
function peco-src () {
  local selected_dir
  selected_dir="$(command ghq list -p | peco --query "$LBUFFER")"
  if [[ -n "$selected_dir" ]]; then
    BUFFER="cd ${(q)selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
if command -v ghq >/dev/null 2>&1 && command -v peco >/dev/null 2>&1; then
  zle -N peco-src
  bindkey '^]' peco-src
fi

# zshrc for each os
case "$OSTYPE" in
# BSD (contains Mac)
darwin*)
  [[ -r "$HOME/.zshrc-darwin" ]] && source "$HOME/.zshrc-darwin"
  ;;
# GNU
linux*)
  [[ -r "$HOME/.zshrc-linux" ]] && source "$HOME/.zshrc-linux"
  ;;
esac

# local zshrc
if [ -f "$HOME/.zshrc-local" ]; then
  source "$HOME/.zshrc-local"
fi
