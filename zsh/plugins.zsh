#!/usr/bin/env zsh

source ~/.dotfiles/antigen/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search # needs to be after syntax-highlighting
antigen bundle djui/alias-tips
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen apply

autoload -U promptinit; promptinit
prompt pure
