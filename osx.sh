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
defaults write com.apple.safari AlwaysShowTabBar -int 1
defaults write com.apple.safari AutoFillPasswords -int 0
defaults write com.apple.safari Command1Through9SwitchesTabs -int 0
defaults write com.apple.safari IncludeDevelopMenu -int 1
defaults write com.apple.safari NewWindowBehavior -int 4
defaults write com.apple.safari SearchProviderIdentifier 'com.duckduckgo'
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1
defaults write com.apple.safari ShowOverlayStatusBar -int 1
defaults write com.apple.safari ShowSidebarInTopSites -int 1
defaults write com.apple.safari TabCreationPolicy -int 0
defaults write com.apple.safari WebKitDeveloperExtrasEnabledPreferenceKey -int 1
defaults write com.apple.safari WebKitTabToLinksPreferenceKey -int 1
defaults write com.apple.safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -int 1
defaults write com.apple.safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" -int 1

# Mail
defaults write com.apple.mail ConversationViewNextMessageDirection -int 2
defaults write com.apple.mail ConversationViewSortDescending -int 0
defaults write com.apple.mail ConversationViewSpansMailboxes -int 1
defaults write com.apple.mail SwipeAction -int 1

# Fantastical 2
defaults write com.flexibits.fantastical2.mac HideDockIcon -int 1
defaults write com.flexibits.fantastical2.mac StatusItemBadge -string StatusItemStyleNone

# Kaleidoscope
defaults write com.blackpixel.kaleidoscope KSIgnoreWhitespaceUserDefaultsKey -int 1
defaults write com.blackpixel.kaleidoscope SUSendProfileInfo -int 0
defaults write com.blackpixel.kaleidoscope KSTextScopeFontInfoUserDefaultsKey -dict \
	fontName -string "FiraMono-Regular" \
	fontSize -int 12


# Script Editor
defaults write com.apple.ScriptEditor2 DefaultLanguageType -int 1785946994
defaults write com.apple.ScriptEditor2 UsesScriptAssistant -int 1

# Tower
defaults write com.fournova.Tower2 GTUserDefaultsAlwaysAutoUpdateSubmodules -int 1
defaults write com.fournova.Tower2 GTUserDefaultsDefaultCloningDirectory -string "/Users/brad/Documents/Code"
defaults write com.fournova.Tower2 GTUserDefaultsDiffToolIdentifier -string kaleidoscope
defaults write com.fournova.Tower2 GTUserDefaultsGitBinary -string "/usr/local/bin/git"
defaults write com.fournova.Tower2 GTUserDefaultsMergeToolIdentifier -string kaleidoscope
# Kill all affected apps
for app in "cfprefsd" "Dock" "Fantastical 2" "Finder" "Mail" "Kaleidoscope" "Safari" "Tower" "SystemUIServer"; do
	killall "${app}" > /dev/null 2>&1
done
