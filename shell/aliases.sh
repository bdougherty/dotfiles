#!/bin/bash

alias -- -="cd -"
alias ...="cd ../.."
alias ..="cd .."
alias https="http --default-scheme=https"
alias ipv4="curl -s https://ipv4.brad.cloud/"
alias ipv6="curl -s https://ipv6.brad.cloud/"
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nr="npm run"
alias nt="npm test"

if command -v gitjk_cmd >/dev/null 2>&1; then
	alias gitjk="history 10 | tail -r | gitjk_cmd"
fi

if command -v thefuck >/dev/null 2>&1; then
	eval "$(thefuck --alias)"
fi

if command -v trash >/dev/null 2>&1; then
	alias rm="trash"
fi

# Flush the DNS cache
function flushdns() {
	if command -v mDNSResponder >/dev/null 2>&1; then
		sudo killall -HUP mDNSResponder
	elif command -v systemd-resolve >/dev/null 2>&1; then
		sudo systemd-resolve --flush-caches
	else
		echo "Don’t know how to clear the DNS cache on this machine, sorry."
		return 1
	fi
}

# Clone a git repo and cd into it
function gc() {
	git clone --recursive "$1" && cd "$(basename "${1%.git}")" || return
}

# Compare original and gzipped file size
function gz() {
	local origsize
	local gzipsize
	local ratio

	origsize=$(wc -c < "$1")
	gzipsize=$(gzip -c "$1" | wc -c)
	ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)

	printf "orig: %d bytes\\n" "$origsize"
	printf "gzip: %d bytes (%2.2f%%)\\n" "$gzipsize" "$ratio"
}

# Search history
function hs() {
	if [[ $ZSH_VERSION ]]; then
		history 1 | grep -i "$@"
	else
		history | grep -i "$@"
	fi
}

# Get local and public ip addresses
function ip() {
	local lan
	local wlan
	local ip_result

	if command -v ipconfig >/dev/null 2>&1; then
		lan=$(ipconfig getifaddr en0)
		wlan=$(ipconfig getifaddr en1)

		if [[ $lan ]]; then
			echo "Ethernet: $lan"
		fi

		if [[ $wlan ]]; then
			echo "Wi-Fi: $wlan"
		fi
	else
		echo "Local: $(hostname -I)"
	fi

	ip_result=$(curl -s https://ip.brad.cloud)

	if [[ $ip_result == *":"* ]]; then
		echo "Public: $(ipv4)"
	fi

	echo "Public: $ip_result"
}

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@" || return
}

# Prevent npm use in a yarn project
function npm() {
	if [[ "$1" != "run" ]]; then
		if [ -f "yarn.lock" ]; then
			echo "$(tput sgr 0 1)$(tput setaf 1)You should use Yarn for this project.$(tput sgr0)"
			return
		fi
	fi

	command npm "$@"
}

# Open the current directory or a file
function o() {
	if [ $# -eq 0 ]; then
		open .
	else
		open "$@"
	fi
}

function refreshproxy() {
	if command -v networksetup >/dev/null 2>&1; then
		local service="Wi-Fi"
		local proxyUrl="http://127.0.0.1:5525/proxy.pac"

		# Turn it off if it's on
		if networksetup -getautoproxyurl Wi-Fi | grep -q 'Enabled: Yes'; then
			echo "Disabling proxy:"
			networksetup -getautoproxyurl "$service"
			networksetup -setautoproxystate "$service" off
			echo ""
		fi

		# Enable proxy if hiproxy is running
		if pgrep -f hiproxy >/dev/null 2>&1; then
			echo "Enabling hiproxy:"
			networksetup -setautoproxyurl "$service" "$proxyUrl"
			networksetup -setautoproxystate "$service" on
			networksetup -getautoproxyurl "$service"
		fi
	else
		echo "Don’t know how to update the proxy settings on this machine, sorry."
		return 1
	fi
}
