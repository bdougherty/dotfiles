#!/usr/bin/env bash

npm_global_packages=(
	caniuse-cmd
	dog-names
	fast-cli
	gitjk
	resume-cli
	superb
	trash-cli
)

npm install --global "${npm_global_packages[@]}"
