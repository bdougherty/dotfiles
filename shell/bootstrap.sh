#!/usr/bin/env bash

export PATH="~/.dotfiles/bin:$PATH"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Opt out of Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# Install homebrew cask to local apps dir
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

if command -v code >/dev/null 2>&1; then
	export EDITOR="code"
	alias dot="code -n ~/.dotfiles"
	alias hosts="code -n /etc/hosts"
else
	export EDITOR="vim"
	alias dot="vim ~/.dotfiles"
	alias hosts="sudo vim /etc/hosts"
fi
