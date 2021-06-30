#!/usr/bin/env bash

GPG_TTY=$(tty)
export GPG_TTY

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="&:ls:cd:pwd:exit:history:hs:[ \t]*"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

if [[ "${BASH_VERSINFO:-0}" -ge 4 ]]; then
	# Enable extended globbing
	shopt -s extblob

	# Automatically change into the typed directory without `cd`
	shopt -s autocd
fi

# Append to history after every command
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Do a history search with the up and down arrows
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

if [[ -a /usr/local/opt/asdf/asdf.sh ]]; then
	source /usr/local/opt/asdf/asdf.sh
fi
