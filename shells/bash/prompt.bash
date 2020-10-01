#!/usr/bin/env bash

#
# Clean and minimalistic Bash prompt
# Author: Artem Sapegin, sapegin.me
#
# Inspired by: https://github.com/sindresorhus/pure & https://github.com/dreadatour/dotfiles/blob/master/.bash_profile
#

RED="$(tput setaf 1)"
BLUE="$(tput setaf 4)"
WHITE="$(tput setaf 7)"
NOCOLOR="$(tput sgr0)"

# User color
case $(id -u) in
	0) user_color="$RED" ;;  # root
	*) user_color="$NOCOLOR" ;;
esac

# Symbols
prompt_symbol=">:"
prompt_clean_symbol=""
prompt_dirty_symbol="* "
prompt_venv_symbol="☁ "

function prompt_command() {
	# Local or SSH session?
	local remote=
	[ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && remote=1

	# Git branch name and work tree status (only when we are inside Git working tree)
	local git_prompt=
	if [[ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		local branch
		local dirty

		branch=$(git symbolic-ref HEAD 2>/dev/null)
		branch="${branch##refs/heads/}"

		dirty=$(git diff --no-ext-diff --quiet --exit-code --ignore-submodules 2>/dev/null || dirty=1)

		# Format Git info
		if [ -n "$dirty" ]; then
			git_prompt=" $branch$prompt_dirty_symbol"
		else
			git_prompt=" $branch$prompt_clean_symbol"
		fi
	fi

	# Virtualenv
	local venv_prompt=
	if [ -n "$VIRTUAL_ENV" ]; then
	    venv_prompt=" $BLUE$prompt_venv_symbol$(basename "$VIRTUAL_ENV")$NOCOLOR"
	fi

	local user_prompt=
	[ -n "$remote" ] && user_prompt="$user_color$USER$NOCOLOR"

	local host_prompt=
	[ -n "$remote" ] && host_prompt="@$HOSTNAME"

	# Show delimiter if user or host visible
	local login_delimiter=
	[ -n "$user_prompt" ] || [ -n "$host_prompt" ] && login_delimiter=" "

	# Format prompt
	first_line="$user_prompt$host_prompt$login_delimiter$BLUE\w$NOCOLOR$git_prompt$venv_prompt"
	# Text (commands) inside \[...\] does not impact line length calculation which fixes stange bug when looking through the history
	# $? is a status of last command, should be processed every time prompt prints
	second_line="\`if [ \$? = 0 ]; then echo \[\$WHITE\]; else echo \[\$RED\]; fi\`\$prompt_symbol\[\$NOCOLOR\] "
	PS1="\n$first_line\n$second_line"

	# Multiline command
	PS2="\[$WHITE\]$prompt_symbol\[$NOCOLOR\] "

	# Terminal title
	local title
	title="$(basename "$PWD")"
	[ -n "$remote" ] && title="$title \xE2\x80\x94 $HOSTNAME"
	echo -ne "\033]0;$title"; echo -ne "\007"
}

# Show awesome prompt only if Git is istalled
command -v git >/dev/null 2>&1 && PROMPT_COMMAND=prompt_command
