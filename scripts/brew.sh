#!/usr/bin/env bash

if command -v brew >/dev/null 2>&1; then
	echo "Homebrew already installed"
	exit 0
fi

eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
