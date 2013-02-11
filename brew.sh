#!/bin/bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Find and fix any issues
brew doctor

# Install wget with IRI support
brew install wget --enable-iri

# Install more recent versions of some OS X tools
# brew tap homebrew/dupes
# brew install homebrew/dupes/grep
# brew tap josegonzalez/homebrew-php
# brew install php54

# Install everything else
brew install browser
brew install closure-compiler
brew install hub
brew install git
brew install node
brew install phantomjs
brew install rename
brew install z

# Remove outdated versions from the cellar
brew cleanup
