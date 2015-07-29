#!/bin/bash

# Dark mode and reduce transparency
defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"
defaults write com.apple.universalaccess reduceTransparency -int 1

# Disable dashboard
defaults write com.apple.dashboard enabled-state -int 1

# Trackpad: enable tap to click and secondary click
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -int 1

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -int 1
defaults write com.apple.universalaccess closeViewPanningMode -int 0

# Show icons for servers and removable media on the desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -int 0
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -int 1
defaults write com.apple.finder ShowMountedServersOnDesktop -int 1
defaults write com.apple.finder ShowRemovableMediaOnDesktop -int 1

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -int 0

# Set up desktop icon view
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 52" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom 0" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo 1" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show home folder when opening new windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Set the icon size of Dock items to 34 or 48 pixels depending on screen size
resolution=$(system_profiler SPDisplaysDataType | grep Resolution)
width=$(echo $resolution | cut -d ' ' -f 2)
height=$(echo $resolution | cut -d ' ' -f 4)

if [[ $(echo $resolution | cut -d ' ' -f 5) == 'Retina' ]]; then
	width=$(echo $width/2 | bc)
	height=$(echo $height/2 | bc)
fi

if [$height -gt 1000]; then
	defaults write com.apple.dock tilesize -int 48
else
	defaults write com.apple.dock tilesize -int 34
fi

# Hot corners
# Top left screen corner → Application Windows
defaults write com.apple.dock wvous-tl-corner -int 3
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom right screen corner → Disable Screen Saver
defaults write com.apple.dock wvous-br-corner -int 6
defaults write com.apple.dock wvous-br-modifier -int 0
# Bottom left screen corner → Start Screen Saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Safari
defaults write -app Safari AlwaysShowTabBar -int 1
defaults write -app Safari AutoFillPasswords -int 0
defaults write -app Safari IncludeDevelopMenu -int 1
defaults write -app Safari NewWindowBehavior -int 4
defaults write -app Safari SearchProviderIdentifier 'com.duckduckgo'
defaults write -app Safari SendDoNotTrackHTTPHeader -int 1
defaults write -app Safari ShowFullURLInSmartSearchField -int 1
defaults write -app Safari ShowSidebarInTopSites -int 1
defaults write -app Safari TabCreationPolicy -int 0
defaults write -app Safari WebKitDeveloperExtrasEnabledPreferenceKey -int 1
defaults write -app Safari WebKitTabToLinksPreferenceKey -int 1
defaults write -app Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -int 1
defaults write -app Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" -int 1

# Mail
defaults write -app Mail ConversationViewNextMessageDirection -int 2
defaults write -app Mail ConversationViewSortDescending -int 0
defaults write -app Mail ConversationViewSpansMailboxes -int 1

# Kaleidoscope
defaults write -app Kaleidoscope KSIgnoreWhitespaceUserDefaultsKey -int 1
defaults write -app Kaleidoscope SUSendProfileInfo -int 0
defaults write -app Kaleidoscope KSTextScopeFontInfoUserDefaultsKey -dict \
	fontName -string "FiraMono-Regular" \
	fontSize -int 12

# Fantastical 2
defaults write -app "Fantastical 2" HideDockIcon -int 1

# Tower
defaults write -app Tower GTUserDefaultsAlwaysAutoUpdateSubmodules -int 1
defaults write -app Tower GTUserDefaultsDefaultCloningDirectory -string "/Users/brad/Documents/Code"
defaults write -app Tower GTUserDefaultsDiffToolIdentifier -string kaleidoscope
defaults write -app Tower GTUserDefaultsGitBinary -string "/usr/local/bin/git"
defaults write -app Tower GTUserDefaultsMergeToolIdentifier -string kaleidoscope

# Script Editor
defaults write -app "Script Editor" DefaultLanguageType -int 1785946994
defaults write -app "Script Editor" UsesScriptAssistant -int 1

# Kill all affected apps
for app in "cfprefsd" "Dock" "Fantastical 2" "Finder" "Mail" "Kaleidoscope" "Safari" "Tower" "SystemUIServer"; do
	killall "${app}" > /dev/null 2>&1
done
