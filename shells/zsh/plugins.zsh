#!/usr/bin/env zsh

# Needs to be done before compinit. See
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if command -v brew >/dev/null 2>&1; then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

if [[ -d "$HOME/.asdf/completions" ]]; then
	FPATH="$HOME/.asdf/completions:${FPATH}"
fi

source "$DOTFILE_PATH/shells/zsh/antigen/antigen.zsh"
antigen init "$DOTFILE_PATH/shells/zsh/.antigenrc"

if command -v brew >/dev/null 2>&1; then
	ASDF_SH="$(brew --prefix)/opt/asdf/asdf.sh"
	if [[ -f $ASDF_SH ]]; then
		source $ASDF_SH
	fi
fi

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
	source "$HOME/.asdf/asdf.sh"
fi
