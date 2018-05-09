#!/usr/bin/env bash

HISTSIZE=1048576
HISTFILE="$HOME/.bash_history"
SAVEHIST=$HISTSIZE
HISTCONTROL=ignoredups:ignorespace
HISTIGNORE="[ \t]*"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Do a history search with the up and down arrows
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Enable colors
export CLICOLOR=1
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
fi
