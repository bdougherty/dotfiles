#!/usr/bin/env bash

npm_global_packages=(
	0x
	caprover
	dog-names
	fast-cli
	gitjk
	hiproxy
	serve
	superb-cli
	trash-cli
)

npm install --global "${npm_global_packages[@]}"
