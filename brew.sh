#!/bin/bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew_formulas=(
	bash-completion
	git
	gpg
	httpie
	httpstat
	hub
	imagemagick
	jq
	keybase
	mas
	node
	python
	shellcheck
	thefuck
	vim
	wget
	yarn
	z
)

brew_browsers=(
	firefox
	caskroom/versions/firefoxdeveloperedition
	google-chrome
	caskroom/versions/google-chrome-canary
	# opera
	# caskroom/versions/opera-developer
	caskroom/versions/safari-technology-preview
)

brew_apps=(
	atom
	banktivity
	charles
	chatology
	daisydisk
	dropshare
	encryptme
	github-desktop
	handbrake
	imageoptim
	kaleidoscope
	minecraft
	pdfpenpro
	qlmarkdown
	querious
	resilio-sync
	screens
	sketch
	steam
	sublime-text
	superduper
	suspicious-package
	tower
	transmit
	vlc
)

brew_global_apps=(
	1password
	vmware-fusion
)

brew_completions=(
	homebrew/completions/apm-bash-completion
	homebrew/completions/brew-cask-completion
	homebrew/completions/fabric-completion
	homebrew/completions/grunt-completion
	homebrew/completions/pip-completion
	homebrew/completions/vagrant-completion
)

brew doctor
brew update
brew install "${brew_formulas[@]}" "${brew_completions[@]}"

read -p "Would you like to install apps with Homebrew? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	brew cask install "${brew_apps[@]}"
	brew cask install --appdir="/Applications" "${brew_browsers[@]}" "${brew_global_apps[@]}"
fi

brew cleanup
