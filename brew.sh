#!/bin/bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew doctor
brew update

brew install bash-completion
brew install gh
brew install git
brew install httpie
brew install imagemagick
brew install jq
brew install node
brew install python
brew install shellcheck
brew install vim
brew install wget
brew install z

brew cleanup
