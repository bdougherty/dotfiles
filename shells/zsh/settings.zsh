#!/usr/bin/env zsh

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
export HISTORY_IGNORE="(ls|cd|pwd|exit|history|hs)"
export PURE_GIT_UNTRACKED_DIRTY=0
export PURE_PROMPT_SYMBOL=">:"

setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt AUTO_CD
setopt CORRECT

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# `fn-delete` (forward delete)
# https://superuser.com/a/169930/165804
bindkey "^[[3~" delete-char

# `shift-tab` to reverse through completions menu
# https://stackoverflow.com/a/842370
bindkey '^[[Z' reverse-menu-complete

# home and end go to beginning and end of line
# https://jdhao.github.io/2019/06/13/zsh_bind_keys/
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# case insensitive (all), partial-word and substring completion
# https://github.com/robbyrussell/oh-my-zsh/blob/e8aba1bf5912f89f408eaebd1bc74c25ba32a62c/lib/completion.zsh#L23
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Menu selection
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
# Highlight
zstyle ':completion:*' menu select
# Tag name as group name
zstyle ':completion:*' group-name ''
# Format group names
zstyle ':completion:*' format '%B---- %d%b'

# Delete Git's official completions to allow Zsh's official Git completions to work.
# Git ships with really bad Zsh completions. Zsh provides its own completions
# for Git, and they are much better.
# https://github.com/Homebrew/homebrew-core/issues/33275#issuecomment-432528793
# https://twitter.com/OliverJAsh/status/1068483170578964480
# Unfortunately it's not possible to install Git without completions (since
# https://github.com/Homebrew/homebrew-core/commit/f710a1395f44224e4bcc3518ee9c13a0dc850be1#r30588883),
# so in order to use Zsh's own completions, we must delete Git's completions.
# This is also necessary for hub's Zsh completions to work:
# https://github.com/github/hub/issues/1956.
function () {
	if command -v brew >/dev/null 2>&1; then
		GIT_ZSH_COMPLETIONS_FILE_PATH="$(brew --prefix)/share/zsh/site-functions/_git"
		if [ -f $GIT_ZSH_COMPLETIONS_FILE_PATH ]; then
			rm $GIT_ZSH_COMPLETIONS_FILE_PATH
		fi
	fi
}

bindkey "^[[" _dirnav_parent # alt-[
bindkey "^[]" _dirnav_child # alt-]
# Other options:
# bindkey "^[;" _dirnav_parent # alt-;
# bindkey "^['" _dirnav_child # alt-'
# bindkey "^[b" _dirnav_parent # alt-left
# bindkey "^[f" _dirnav_child # alt-right
