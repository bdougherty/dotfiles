#!/usr/bin/env bash

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias c="pygmentize -O style=monokai -f console256 -g"
alias gitjk="history 10 | tail -r | gitjk_cmd"
alias ip="curl -s https://ip.brad.is/"
alias ipv4="dig +short myip.opendns.com @resolver1.opendns.com"
alias o="open"
alias oo="open ."
alias ql="qlmanage -p"
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1]);"'
alias resetprefs="killall -SIGTERM cfprefsd"
alias wow=echo
alias very=cat
alias such=grep
alias emojis="open http://www.emoji-cheat-sheet.com/"
alias devdocs="open https://devdocs.io"

if which trash >/dev/null 2>&1; then
	alias rm="trash"
fi

if which thefuck >/dev/null 2>&1; then
	eval "$(thefuck --alias)"
else
	alias fuck='sudo $(history -p \!\!)'
fi

function ips() {
	local ip_result
	ip_result=$(ip)

	# get the IPv4 address also if it’s an IPv6 address
	if [[ $ip_result == *":"* ]]; then
		ipv4
	fi

	echo "$ip_result"
}

function localip() {
	if which ipconfig >/dev/null 2>&1; then
		ipconfig getifaddr en0 ; ipconfig getifaddr en1
	else
		hostname -I
	fi
}

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
	python ~/.dotfiles/server.py --port="$port"
}

# Compare original and gzipped file size
function gz() {
	local origsize
	local gzipsize
	local ratio

	origsize=$(wc -c < "$1")
	gzipsize=$(gzip -c "$1" | wc -c)
	ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)

	printf "orig: %d bytes\n" "$origsize"
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Extract archives - use: extract <file> <dir>
function extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2) tar xjf $1 -C $2 ;;
			*.tar.gz) tar xzf $1 -C $2 ;;
			*.bz2) bunzip2 $1 ;;
			*.rar) rar x $1 ;;
			*.gz) gunzip $1 ;;
			*.tar) tar xf $1 -C $2 ;;
			*.tbz2) tar xjf $1 -C $2 ;;
			*.tgz) tar xzf $1 -C $2 ;;
			*.zip) unzip $1 -d $2 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*) echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

function proxy() {
	# Only supported on OS X
	if [[ $(uname) != "Darwin" ]]; then
		echo "This command only works on OS X"
		return
	fi

	# Make sure that mitmproxy is installed
	if ! which mitmproxy >/dev/null 2>&1; then
		if ! which pip >/dev/null 2>&1; then
			echo "pip must be installed in order to install mitmproxy"
			return
		fi

		pip install mitmproxy
	fi

	# Prefer Wi-Fi if connected
	local interface='Wi-Fi'
	if networksetup -getinfo 'Ethernet' | grep 'IP Address' >/dev/null 2>&1; then
		interface='Ethernet'
	fi

	# Set up the necessary settings
	sudo networksetup -setwebproxy $interface 127.0.0.1 8080
	sudo networksetup -setwebproxystate $interface on
	sudo networksetup -setsecurewebproxy $interface 127.0.0.1 8080
	sudo networksetup -setsecurewebproxystate $interface on

	# Start the proxy and wait for it to finish
	mitmproxy
	wait

	# Remove proxy automatically when closing mitmproxy
	sudo networksetup -setwebproxystate $interface off
	sudo networksetup -setsecurewebproxystate $interface off
}

## Print a horizontal rule
rule() {
	printf "%$(tput cols)s\n"|tr " " "─"
}

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Store multi-line commands as one line in history
shopt -s cmdhist

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# export VAGRANT_DEFAULT_PROVIDER=parallels

# Enable colors
export CLICOLOR=1
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	# alias grep='grep --color=auto'
	# alias fgrep='fgrep --color=auto'
	# alias egrep='egrep --color=auto'
fi

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups:ignorespace

# Ignore any commands that start with a space
export HISTIGNORE="[ \t]*"

if which atom >/dev/null 2>&1; then
	export EDITOR="atom -w -n"
	alias dot="atom -n ~/.dotfiles"
	alias hosts="atom -n /etc/hosts"
elif which subl >/dev/null 2>&1; then
	export EDITOR="subl -w -n"
	alias dot="subl -n ~/.dotfiles"
	alias hosts="subl -n /etc/hosts"
elif which vim >/dev/null 2>&1; then
	export EDITOR="vim"
	alias dot="vim ~/.dotfiles"
	alias hosts="sudo vim /etc/hosts"
else
	export EDITOR="vi"
	alias dot="vi ~/.dotfiles"
	alias hosts="sudo vi /etc/hosts"
fi

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Opt out of Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# Do a history search with the up and down arrows
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -r "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host " ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add more bash completions
if which brew >/dev/null 2>&1 && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	# shellcheck source=/dev/null
	source "$(brew --prefix)/etc/bash_completion"
elif [ -f /etc/bash_completion ]; then
	# shellcheck disable=SC1091
	source /etc/bash_completion
fi

# Add rbenv shims and autocompletion
if which rbenv >/dev/null 2>&1; then eval "$(rbenv init -)"; fi

# Add z
if which brew >/dev/null 2>&1 && [ -f "$(brew --prefix)/etc/profile.d/z.sh" ]; then
	# shellcheck source=/dev/null
	source "$(brew --prefix)/etc/profile.d/z.sh"
fi

# Add nice prompt with git stuff
# shellcheck disable=SC1091
source ~/.dotfiles/.bash_prompt

export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

# Run any extra stuff
# shellcheck disable=SC1091
[ -r .extra ] && source .extra

if which git >/dev/null 2>&1 && which hub >/dev/null 2>&1; then
	eval "$(hub alias -s)"
fi
