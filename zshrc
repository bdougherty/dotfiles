#!/usr/bin/env zsh

if [ -f ~/.shell.local.before ]; then
	source ~/.shell.local.before
fi

if [ -f ~/.zshrc.local.before ]; then
	source ~/.zshrc.local.before
fi

source ~/.shell/bootstrap.sh
source ~/.shell/aliases.sh
source ~/.zsh/plugins.zsh
source ~/.zsh/settings.zsh

if [ -f ~/.zshrc.local.after ]; then
	source ~/.zshrc.local.after
fi

if [ -f ~/.shell.local.after ]; then
	source ~/.shell.local.after
fi
