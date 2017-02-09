#!/bin/bash

yarn_global_packages=(
	ava
	caniuse-cmd
	diff-so-fancy
	eslint
	fast-cli
	gitjk
	grunt-cli
	jsonlint
	remark
	remark-lint
	sass-lint
	tldr
	trash-cli
)

yarn global add "${yarn_global_packages[@]}"
