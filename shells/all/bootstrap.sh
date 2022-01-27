#!/usr/bin/env bash

export DOTFILE_PATH="$HOME/.dotfiles"
export PATH="$DOTFILE_PATH/bin:$PATH"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

export AUTHOR_NAME="Brad Dougherty"
export AUTHOR_EMAIL="me@brad.is"

# Set npm here so ~/.npmrc can have secrets
export NPM_CONFIG_DEPTH=0
export NPM_CONFIG_INIT_AUTHOR_NAME=$AUTHOR_NAME
export NPM_CONFIG_INIT_AUTHOR_EMAIL=$AUTHOR_EMAIL
export NPM_CONFIG_INIT_LICENSE="MIT"
export NPM_CONFIG_SIGN_GIT_COMMIT=true
export NPM_CONFIG_SIGN_GIT_TAG=true

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export CYPRESS_CRASH_REPORTS=0

# Opt out of Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# Install homebrew cask to local apps dir
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

if command -v code >/dev/null 2>&1; then
	export GIT_EDITOR="code -w -n"
	alias dot="code -n ~/.dotfiles"
	alias hosts="code -n /etc/hosts"
elif command -v micro >/dev/null 2>&1; then
	export EDITOR="micro"
	alias dot="micro ~/.dotfiles"
	alias hosts="sudo micro /etc/hosts"
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
	(test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)") || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

if command -v mkcert >/dev/null 2>&1; then
	NODE_EXTRA_CA_CERTS="$HOME/Library/Application Support/mkcert/rootCA.pem"
	export NODE_EXTRA_CA_CERTS
fi
