#!/usr/bin/env zsh

# Needs to be done before compinit. See
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $DOTFILE_PATH/shells/zsh/antigen/antigen.zsh
antigen init $DOTFILE_PATH/shells/zsh/.antigenrc
