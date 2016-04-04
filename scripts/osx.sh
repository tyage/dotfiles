#!/bin/sh

# install brew
echo "install brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install packages
echo "install packages"
brew install git tig vim wireshark p7zip node wget nginx peco zsh mackerel-agent

# chsh for zsh
echo "chsh for zsh"
chsh -s /usr/local/bin/zsh

# setup for ruby
echo "setup for ruby"
brew install rbenv ruby-build
rbenv install 2.3.0
rbenv global 2.3.0
gem install bundle

# install applications
echo "install applications"
brew cask install gyazo skype dropbox slack dash night-owl virtualbox atom tunnelblick firefox google-japanese-ime gnucash vlc

# homesick
gem install homesick
homesick clone tyage/dotfiles
homesick symlink

# setup for atom
