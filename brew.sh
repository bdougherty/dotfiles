#!/bin/bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew doctor
brew update

brew install bash-completion
brew install git
brew install gh
brew install httpie
brew install imagemagick
brew install node
brew install python
brew install wget
brew install z

brew cleanup
