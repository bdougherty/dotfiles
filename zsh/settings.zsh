#!/usr/bin/env zsh

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTORY_IGNORE="(ls|cd|pwd|exit|history|hs)"

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
