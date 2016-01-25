alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias c="pygmentize -O style=monokai -f console256 -g"
alias fuck="sudo $(history -p \!\!)"
alias gitjk="history 10 | tail -r | gitjk_cmd"
alias ip="curl -s https://brad.is/ip/"
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
alias dot="subl ~/.dotfiles"
alias emojis="open http://www.emoji-cheat-sheet.com/"
alias devdocs="open https://devdocs.io"

function ips {
	local ip_result=$(ip)

	# get the IPv4 address also if it’s an IPv6 address
	if [[ $ip_result == *":"* ]]; then
		echo $(ipv4)
	fi

	echo $ip_result
}

function anybar {
	echo -n $1 | nc -4u -w0 localhost ${2:-1738};
}

function localip {
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
	python ~/.dotfiles/server.py --port=$port
}

# Compare original and gzipped file size
function gz() {
	local origsize=$(wc -c < "$1")
	local gzipsize=$(gzip -c "$1" | wc -c)
	local ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)
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
	if [[ `uname` != "Darwin" ]]; then
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

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Store multi-line commands as one line in history
shopt -s cmdhist

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
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
export HISTCONTROL=ignoredups

# Ignore any commands that start with a space
export HISTIGNORE="[ \t]*"

if which subl >/dev/null 2>&1; then
	export EDITOR="subl -w -n"
elif which vim >/dev/null 2>&1; then
	export EDITOR="vim"
else
	export EDITOR="vi"
fi

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Do a history search with the up and down arrows
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -r "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host " ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add more bash completions
if which brew >/dev/null 2>&1 && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

# Add rbenv shims and autocompletion
if which rbenv >/dev/null 2>&1; then eval "$(rbenv init -)"; fi

# Add z
if which brew >/dev/null 2>&1 && [ -f "$(brew --prefix)/etc/profile.d/z.sh" ]; then
	source `brew --prefix`/etc/profile.d/z.sh
fi

# Add nice prompt with git stuff
source ~/.dotfiles/.bash_prompt

# Run any extra stuff
[ -r .extra ] && source .extra

# From http://stackoverflow.com/a/4025065
function vercomp() {
	if [[ $1 == $2 ]]
		then
		return 0
	fi
	local IFS=.
	local i ver1=($1) ver2=($2)
	# fill empty fields in ver1 with zeros
	for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
	do
		ver1[i]=0
	done
	for ((i=0; i<${#ver1[@]}; i++))
	do
		if [[ -z ${ver2[i]} ]]
			then
	# fill empty fields in ver2 with zeros
	ver2[i]=0
	fi
	if ((10#${ver1[i]} > 10#${ver2[i]}))
		then
		return 1
	fi
	if ((10#${ver1[i]} < 10#${ver2[i]}))
		then
		return 2
	fi
	done
	return 0
}

if which git >/dev/null 2>&1; then
	git config --global alias.ci commit
	git config --global alias.st status
	git config --global alias.co checkout
	git config --global alias.dt difftool
	git config --global alias.dts "difftool --staged"
	git config --global alias.mt mergetool
	git config --global alias.amend "commit --amend"
	git config --global alias.sub "submodule update --init --recursive"
	git config --global alias.reb "!r() { git rebase -i HEAD~$1; }; r"
	git config --global alias.contributors "shortlog --summary --numbered"
	git config --global alias.restore '!f() { git checkout $(git rev-list -n 1 HEAD -- $1)^ -- $1; }; f'
	git config --global alias.restorec '!f() { git checkout $(git rev-list -n 1 HEAD -- $1)~1 -- $(git diff --name-status $(git rev-list -n 1 HEAD -- $1)~1 | grep '^D' | cut -f 2); }; f'
	git config --global alias.wipe "!git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard"
	git config --global alias.up "!git pull --rebase --prune $@ && git submodule update --init --recursive"
	git config --global apply.whitespace fix
	git config --global branch.autosetupmerge always
	git config --global color.branch.current 'yellow black'
	git config --global color.branch.local 'yellow'
	git config --global color.branch.remote 'magenta'
	git config --global color.diff.meta 'yellow bold'
	git config --global color.diff.frag 'magenta bold'
	git config --global color.diff.old 'red reverse'
	git config --global color.diff.new 'green reverse'
	git config --global color.diff.whitespace 'white reverse'
	git config --global color.status.added 'yellow'
	git config --global color.status.changed 'green'
	git config --global color.status.untracked 'cyan reverse'
	git config --global color.status.branch 'magenta bold'
	git config --global core.editor "$EDITOR"
	git config --global core.trustctime false
	git config --global fetch.prune true
	git config --global help.autocorrect 100
	git config --global pull.rebase true
	git config --global rebase.autostash true
	git config --global rerere.enabled true
	git config --global rerere.autoupdate true

	git config --global gh.host "github.vimeows.com"
	git config --global url."git@github.com:bdougherty/".insteadOf "git://github.com/bdougherty/"
	git config --global user.name "Brad Dougherty"
	git config --global user.email "me@brad.is"

	# Set push.default to simple, but only in Git 1.7.11 and higher
	vercomp `git --version 2>/dev/null 2>&1 | awk '{print $NF; exit}'` '1.7.11' >/dev/null 2>&1
	if [ $? -lt 2 ]; then
		git config --global push.default simple
	else
		git config --global --unset push.default
	fi

	# Set the diff/merge tools to be Kaleidoscope if available
	if which ksdiff >/dev/null 2>&1; then
		# https://github.com/rustle/KaleidoscopeVCSTidbits
		git config --global alias.ksreview '!f() { local SHA=${1:-HEAD}; local BRANCH=${2:-master}; if [ $SHA == $BRANCH ]; then SHA=HEAD; fi; git difftool -y -t Kaleidoscope $BRANCH...$SHA; }; f'
		git config --global alias.ksshow '!f() { local SHA=${1:-HEAD}; git difftool -y -t Kaleidoscope $SHA^..$SHA; }; f'

		git config --global diff.tool Kaleidoscope
		git config --global difftool.prompt false
		git config --global difftool.Kaleidoscope.cmd "ksdiff --partial-changeset --relative-path \"\$MERGED\" -- \"\$LOCAL\" \"\$REMOTE\""
		git config --global merge.tool Kaleidoscope
		git config --global mergetool.prompt false
		git config --global mergetool.Kaleidoscope.cmd "ksdiff --merge --output \"\$MERGED\" --base \"\$BASE\" -- \"\$LOCAL\" \"\$REMOTE\""
	elif which vimdiff >/dev/null 2>&1; then
		git config --global diff.tool vimdiff
		git config --global difftool.prompt false
	fi

	# Alias git to gh if it's installed
	if which gh >/dev/null 2>&1; then eval "$(gh alias -s)"; fi
fi
