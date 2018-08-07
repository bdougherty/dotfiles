#!/usr/bin/env bash

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="&:ls:cd:pwd:exit:history:hs:[ \t]*"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable extended globbing
shopt -s extblob

# Automatically change into the typed directory without `cd`
shopt -s autocd

# Append to history after every command
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Do a history search with the up and down arrows
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Enable colors
export CLICOLOR=1
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
fi
