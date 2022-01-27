#!/usr/bin/env bash

if ! command -v asdf >/dev/null 2>&1; then
	if command -v brew >/dev/null 2>&1; then
		echo "Installing asdf via homebrew"
		brew install asdf
		# shellcheck disable=SC1091
		source "$(brew --prefix asdf)/asdf.sh"
	else
		echo "Installing asdf via git"
		git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
		# shellcheck disable=SC1091
		source "$HOME/.asdf/asdf.sh"
	fi
fi

asdf plugin-add nodejs
asdf install nodejs latest
asdf global nodejs latest

asdf plugin-add python
asdf install python latest
asdf global python latest

asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf install deno latest
asdf global deno latest
