#!/bin/bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap caskroom/cask
brew doctor
brew update

brew install bash-completion
brew install gh
brew install git
brew install gpg
brew install httpie
brew install imagemagick
brew install jq
brew install keybase
brew install node
brew install python
brew install shellcheck
brew install vim
brew install wget
brew install z
brew cask install qlmarkdown

brew cleanup
