#!/usr/bin/env bash

sudo -v

GITHUB_KEYRING="/usr/share/keyrings/githubcli-archive-keyring.gpg"
if [[ ! -f $GITHUB_KEYRING ]]; then
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o "$GITHUB_KEYRING"
	echo "deb [arch=$(dpkg --print-architecture) signed-by=$GITHUB_KEYRING] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
fi

sudo add-apt-repository -y ppa:aos1/diff-so-fancy

sudo apt update
sudo apt install -y diff-so-fancy gh httpie jq zsh
