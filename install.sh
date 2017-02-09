#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" || exit

function removeOldFiles() {
	for file in ~/.{aliases,bash_profile,bash_prompt,bashrc,exports,functions,gitconfig,hushlogin,inputrc,path,wgetrc,hub-completion.sh,git-completion.sh,vimrc}; do
		rm "$file" >/dev/null 2>&1
	done
}

function copyNewFiles() {
	cp .bash_profile ~/.bash_profile
	cp .bashrc ~/.bashrc
	cp .vim ~/.vimrc
	ln -s .gitconfig ~/.gitconfig
}

function doIt() {
	removeOldFiles
	copyNewFiles
	source ~/.bash_profile
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi

# Install Homebrew on OS X
if [[ $(uname) == 'Darwin' ]]; then
	read -p "Would you like to set up Homebrew? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./brew.sh
	fi

	read -p "Would you like to set up OS X preferences? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./osx.sh
	fi

	read -p "Would you like to install apps from the Mac App Store? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./mas.sh
	fi
fi

# Install yarn packages
if which yarn > /dev/null; then
	read -p "Would you like to install yarn packages? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./yarn.sh
	fi
fi
