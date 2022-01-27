#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

sudo -v

# enable touch id for sudo
#awk 'NR==2 {print "auth       sufficient     pam_tid.so"} {print}' /etc/pam.d/sudo | sudo tee -a /etc/pam.d/sudo > /dev/null

# Prevent Safari ad notifications
# https://lapcatsoftware.com/articles/TRYTHENEWSAFARI.html
defaults write com.apple.coreservices.uiagent CSUIHasSafariBeenLaunched -bool YES
defaults write com.apple.coreservices.uiagent CSUILastOSVersionWhereSafariRecommendationWasMade -float 99.0
defaults write com.apple.coreservices.uiagent CSUIRecommendSafariNextNotificationDate -date "2050-01-01 00:00:00 +0000"

# Prevent App Store notifications
# https://lapcatsoftware.com/articles/mas-notifications.html
defaults write com.apple.appstored LastUpdateNotification -date "2029-12-12 12:00:00 +0000"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

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

# Show home folder when opening new windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -int 0

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Set up desktop icon view
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom 0" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo 1" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 50" ~/Library/Preferences/com.apple.finder.plist

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library > /dev/null 2>&1

# Dock
defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock "show-recents" -int 0
defaults write com.apple.dock slow-motion-allowed -bool YES

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

# Disable app store review popups
defaults write com.apple.AppStore InAppReviewEnabled -int 0

# Mail
defaults write com.apple.mail SwipeAction -int 1
defaults write com.apple.mail NewMessagesSoundName ""

# Safari
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -int 1
defaults write com.apple.Safari AlwaysShowTabBar -int 1
defaults write com.apple.Safari AutoFillPasswords -int 0
defaults write com.apple.Safari Command1Through9SwitchesTabs -int 0
defaults write com.apple.Safari ExcludePrivateWindowWhenRestoringSessionAtLaunch -int 1
defaults write com.apple.Safari FavoritesViewCollectionBookmarkUUID "97D2F699-F4F5-4629-BFF4-694EFB3B7A85"
defaults write com.apple.Safari IncludeDevelopMenu -int 1
defaults write com.apple.Safari "ReaderConfiguration.fontFamilyNameForLanguageTag.en" "Charter"
defaults write com.apple.Safari SearchProviderIdentifier "com.duckduckgo"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -int 1
defaults write com.apple.Safari ShowOverlayStatusBar -int 1
# defaults write com.apple.Safari UserStyleSheetLocationURLString "$HOME/.dotfiles/safari/user.css"
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -int 1
defaults write com.apple.Safari "WebKitPreferences.developerExtrasEnabled" -int 1
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -int 1

# Terminal
#defaults write -app Terminal "Default Window Settings" "One Dark"
#defaults write -app Terminal "Startup Window Settings" "One Dark"

# Battery Indicator
if osascript -e 'id of application "Battery Indicator"' >/dev/null 2>&1; then
	defaults write com.sindresorhus.Battery-Indicator hideIconWhenOnPower -int 0
	defaults write com.sindresorhus.Battery-Indicator showPercentage -int 0
	defaults write com.sindresorhus.Battery-Indicator smallMenuBarText -int 1
	defaults write com.sindresorhus.Battery-Indicator textOnlyIcon -int 1
fi

# HapticKey
if osascript -e 'id of application "HapticKey"' >/dev/null 2>&1; then
	defaults write at.niw.HapticKey FeedbackType -int 2
	defaults write at.niw.HapticKey ListeningEventType -int 2
	defaults write at.niw.HapticKey SUEnableAutomaticChecks -int 1
fi

# Reeder
if osascript -e 'id of application "Reeder"' >/dev/null 2>&1; then
	defaults write com.reederapp.5.macOS app.appearance -int 30
	defaults write com.reederapp.5.macOS app.item-order -int 1
	defaults write com.reederapp.5.macOS app.icon-badge -int 2
	defaults write com.reederapp.5.macOS app.layout -int 4
	defaults write com.reederapp.5.macOS appearance.classic -int 0
	defaults write com.reederapp.5.macOS article.increase-contrast -int 1
	defaults write com.reederapp.5.macOS bionic.toolbar -int 1
	defaults write com.reederapp.5.macOS open-links-in-background -int 1
	defaults write com.reederapp.5.macOS open-links-in-default-browser -int 1
	defaults write com.reederapp.5.macOS app.item-group-by-feed -int 0
	defaults write com.reederapp.5.macOS app.toolbar-sharing-services -array "com.reederapp.internal.ReadLater" "com.reederapp.internal.ReadingList" "com.reederapp.internal.CopyLink"
fi

# Things
if osascript -e 'id of application "Things"' >/dev/null 2>&1; then
	defaults write com.culturedcode.ThingsMac CCDockCountType -int 1
	defaults write com.culturedcode.ThingsMac PreserveWindowWidthWhenResizingSidebar -int 1
	defaults write com.culturedcode.ThingsMac UriSchemeEnabled -int 1
fi

# Transmit
if osascript -e 'id of application "Transmit"' >/dev/null 2>&1; then
	defaults write com.panic.Transmit AllowDataCollection -int 0
	defaults write com.panic.Transmit DoubleClickAction -int 3
fi
