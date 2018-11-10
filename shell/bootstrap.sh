#!/usr/bin/env bash

export PATH="$HOME/.dotfiles/bin:$PATH"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Opt out of Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# Install homebrew cask to local apps dir
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

if command -v code >/dev/null 2>&1; then
	export GIT_EDITOR="code -w -n"
	alias dot="code -n ~/.dotfiles"
	alias hosts="code -n /etc/hosts"
elif command -v vim >/dev/null 2>&1; then
	export EDITOR="vim"
	alias dot="vim ~/.dotfiles"
	alias hosts="sudo vim /etc/hosts"
else
	export EDITOR="nano"
	alias dot="nano ~/.dotfiles"
	alias hosts="sudo nano /etc/hosts"
fi

# Enable colors
export CLICOLOR=1
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

GPG_TTY=$(tty)
export GPG_TTY
