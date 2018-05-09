#!/usr/bin/env bash

if [ -f ~/.shell.local.before ]; then
	source ~/.shell.local.before
fi

if [ -f ~/.bashrc.local.before ]; then
	source ~/.bashrc.local.before
fi

source ~/.bash/settings.bash
source ~/.shell/bootstrap.sh
source ~/.shell/aliases.sh
source ~/.bash/prompt.bash

if [ -f ~/.bashrc.local.after ]; then
	source ~/.bashrc.local.after
fi

if [ -f ~/.shell.local.after ]; then
	source ~/.shell.local.after
fi
