#!/usr/bin/env zsh

# Needs to be done before compinit. See
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if command -v brew >/dev/null 2>&1; then
	FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

if [[ -a /usr/local/opt/asdf/asdf.sh ]]; then
	source /usr/local/opt/asdf/asdf.sh
fi

if [[ -d $HOME/.asdf ]]; then
	FPATH=$HOME/.asdf/completions:$FPATH
	source $HOME/.asdf/asdf.sh
fi

source $DOTFILE_PATH/shells/zsh/antigen/antigen.zsh
antigen init $DOTFILE_PATH/shells/zsh/.antigenrc
