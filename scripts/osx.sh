#!/bin/sh

# install brew
echo "install brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install packages
echo "install packages"
brew install git tig vim wireshark p7zip node wget nginx peco zsh

# chsh for zsh
echo "chsh for zsh"
sudo echo "/usr/local/bin/zsh" >> /etc/shells
chsh -s /usr/local/bin/zsh

# setup for ruby
echo "setup for ruby"
brew install rbenv ruby-build
rbenv install 2.3.0
rbenv global 2.3.0
gem install bundle

# install applications
echo "install applications"
brew cask install gyazo skype dropbox slack dash night-owl virtualbox atom tunnelblick firefox google-japanese-ime gnucash vlc google-chrome google-drive

# homesick
echo "homesick"
gem install homesick
homesick clone tyage/dotfiles
homesick symlink

# install mackerel-agent
echo "install mackerel agent"
brew tap mackerelio/mackerel-agent
brew install mackerel-agent

# install source code pro
echo "install source code pro"
brew tap caskroom/fonts
brew cask install font-source-code-pro
