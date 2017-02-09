#!/bin/bash
#
## Make sure homebrew is installed first
if [[ ! "$(type -P mas)" ]]; then
	echo "Installing mas cli"
	brew install mas
fi

# Install Xcode first
mas install 497799835  # Xcode

mas_apps=(
	1107421413 # 1Blocker
	477670270  # 2Do
	411643860  # DaisyDisk
	1055511498 # Day One
	924726344  # Deliveries
	1173932628 # Drop (color picker)
	1056077392 # DxOOpticsProForPhotos
	975937182  # Fantastical 2
	409183694  # Keynote
	1037755919 # MacFamilyTree 8
	603637384  # Name Mangler 3
	409203825  # Numbers
	409201541  # Pages
	407963104  # Pixelmator
	880001334  # Reeder
	446107677  # Screens
	803453959  # Slack
	413965349  # Soulver
	896450579  # Textual
	557168941  # Tweetbot
)

mas install "${mas_apps[@]}"
