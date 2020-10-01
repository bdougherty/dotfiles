#!/usr/bin/env bash

calculate_dock_and_desktop_icon_sizes() {
	local resolution
	local width
	local height

	resolution=$(system_profiler SPDisplaysDataType | grep Resolution | sed 's/^ *//;s/ *$//')
	width=$(echo "$resolution" | cut -d ' ' -f 2)
	height=$(echo "$resolution" | cut -d ' ' -f 4)

	if [[ $(echo "$resolution" | cut -d ' ' -f 5) == 'Retina' ]]; then
		width=$(echo "$width/2" | bc)
		height=$(echo "$height/2" | bc)
	fi

	if [[ "$height" -gt 1000 ]]; then
		dock_icon_size=48
		desktop_icon_size=64
	else
		dock_icon_size=34
		desktop_icon_size=52
	fi

	export dock_icon_size
	export desktop_icon_size
}


#  -- System Preferences -- #


# Dark mode
defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"

# Disable dashboard
defaults write com.apple.dashboard enabled-state -int 1

# Trackpad: enable tap to click and secondary click
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0 # Magic Trackpad 2 silent clicking
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

# Set the icon size of Dock icons depending on screen size
defaults write com.apple.dock tilesize -int $dock_icon_size

# Set up desktop icon view
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom 0" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo 1" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize $desktop_icon_size" ~/Library/Preferences/com.apple.finder.plist

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

# Don’t open Photos when plugging in an iPhone
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES


# -- App Preferences -- #


# Fantastical 2
defaults write -app "Fantastical 2" HideDockIcon -int 1
defaults write -app "Fantastical 2" StatusItemBadge -string StatusItemStyleNone

# Mail
defaults write -app Mail ConversationViewNextMessageDirection -int 2
defaults write -app Mail ConversationViewSortDescending -int 0
defaults write -app Mail ConversationViewSpansMailboxes -int 1
defaults write -app Mail SwipeAction -int 1

# Reeder
defaults write -app Reeder AppIconUnreadCount -int 2
defaults write -app Reeder AppOrderUnreadItems -int 1
defaults write -app Reeder OpenLinksInBackground -int 1
defaults write -app Reeder PrivateBrowsing -int 1
defaults write -app Reeder WebKitPrivateBrowsingEnabled -int 1
defaults write -app Reeder ShareRKServiceInstapaper -dict enabled -int 0 "show-in-toolbar" -int 0
defaults write -app Reeder ShareRKServicePocket -dict enabled -int 0 "show-in-toolbar" -int 0
defaults write -app Reeder ShareRKServiceReadingList -dict enabled -int 1 "show-in-toolbar" -int 1
defaults write -app Reeder ShareRKServiceEvernote -dict enabled -int 0 "show-in-toolbar" -int 0
defaults write -app Reeder ShareRKServiceMarsEdit -dict enabled -int 0 "show-in-toolbar" -int 0
defaults write -app Reeder ShareRKServicePinboard -dict enabled -int 1 "show-in-toolbar" -int 1
defaults write -app Reeder ShareRKServiceTwitter -dict enabled -int 0 "show-in-toolbar" -int 0
defaults write -app Reeder ShareRKServiceFacebook -dict enabled -int 0 "show-in-toolbar" -int 0
defaults write -app Reeder ShareRKServiceBuffer -dict enabled -int 0 "show-in-toolbar" -int 0

# Safari
defaults write -app Safari AlwaysShowTabBar -int 1
defaults write -app Safari AutoFillPasswords -int 0
defaults write -app Safari Command1Through9SwitchesTabs -int 0
defaults write -app Safari IncludeDevelopMenu -int 1
defaults write -app Safari NewWindowBehavior -int 4
defaults write -app Safari SearchProviderIdentifier "com.duckduckgo"
defaults write -app Safari SendDoNotTrackHTTPHeader -int 1
defaults write -app Safari ShowFullURLInSmartSearchField -int 1
defaults write -app Safari ShowOverlayStatusBar -int 1
defaults write -app Safari ShowSidebarInTopSites -int 1
defaults write -app Safari TabCreationPolicy -int 0
defaults write -app Safari UserStyleSheetLocationURLString "~/.dotfiles/safari/user.css"
defaults write -app Safari WebKitDeveloperExtrasEnabledPreferenceKey -int 1
defaults write -app Safari WebKitTabToLinksPreferenceKey -int 1
defaults write -app Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -int 1
defaults write -app Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" -int 1
defaults write -app Safari "ReaderConfiguration.themeName" "sepia"
defaults write -app Safari "ReaderConfiguration.fontFamilyNameForLanguageTag.en" "Charter"

# Script Editor
defaults write -app "Script Editor" DefaultLanguageType -int 1785946994
defaults write -app "Script Editor" UsesScriptAssistant -int 1

# Terminal
defaults write -app Terminal "Default Window Settings" "One Dark"
defaults write -app Terminal "Startup Window Settings" "One Dark"

# Things
# defaults write -app Things3 CCDockCountType -int 1
# defaults write -app Things3 PreserveWindowWidthWhenResizingSidebar -int 1
# defaults write -app Things3 TodayWidgetCanLaunchThings -int 1
# defaults write -app Things3 UriSchemeEnabled -int 1

# Transmit
defaults write -app Transmit DoubleClickAction -int 3

# Tweetbot
defaults write -app Tweetbot badgesEnabled -int 0
defaults write -app Tweetbot displayNameType -int 3
defaults write -app Tweetbot OpenURLsDirectly YES
defaults write -app Tweetbot openURLInBackground -int 1
defaults write -app Tweetbot roundAvatars -int 0
defaults write -app Tweetbot showStatusItem -int 0
defaults write -app Tweetbot soundType -int 1
