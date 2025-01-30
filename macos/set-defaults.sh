#!/usr/bin/env bash
#
# Configure macOS defaults for development

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo ""; echo -e "${BLUE}➜${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }

echo ""
warn "This will change macOS system settings."
echo "Close System Settings before continuing."
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Ask for administrator password upfront
sudo -v

# Keep sudo alive until script completes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Performance & Animations (macOS Tahoe 26 optimized)                         #
###############################################################################

step "Configuring performance & animation settings"

# Dock animasyonlarini hizlandir
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock autohide-delay -float 0

# Launchpad animasyonlarini hizlandir
defaults write com.apple.dock springboard-show-duration -float 0.1
defaults write com.apple.dock springboard-hide-duration -float 0.1

# Mission Control animasyonunu hizlandir
defaults write com.apple.dock expose-animation-duration -float 0.1

# Pencere animasyonlarini devre disi birak
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Bilgi penceresi animasyonunu devre disi birak
defaults write com.apple.finder DisableAllAnimations -bool true

# Rubber-band scrolling'i devre disi birak
defaults write -g NSScrollViewRubberbanding -bool false

success "Performance settings configured"

###############################################################################
# Window Management                                                           #
###############################################################################

step "Configuring window management"

# Window drag anywhere with Cmd+Ctrl+Click
defaults write -g NSWindowShouldDragOnGesture -bool true

success "Window management configured"

###############################################################################
# General UI/UX                                                               #
###############################################################################

step "Configuring general UI/UX settings"

# Crash reporter'ı notification olarak göster (popup yerine)
defaults write com.apple.CrashReporter UseUNC 1

# Help Viewer penceresini normal pencere yap (floating değil)
defaults write com.apple.helpviewer DevMode -bool true

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

success "General settings configured"

###############################################################################
# Sound                                                                       #
###############################################################################

step "Configuring sound settings"

# UI ses efektlerini kapat
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 0

# Volume değişikliğinde feedback sesi kapat
defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool false

success "Sound settings configured"

###############################################################################
# Bluetooth                                                                   #
###############################################################################

step "Configuring Bluetooth settings"

# Bluetooth audio codec'i AAC olarak zorla (daha iyi kalite)
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

success "Bluetooth settings configured"

###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################

step "Configuring SSD & energy optimizations"

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Disable the sudden motion sensor as it's not useful for SSDs
sudo pmset -a sms 0

# Standby delay'i 24 saate cikar
sudo pmset -a standbydelay 86400

# Power Nap'i devre disi birak (arka plan sync yok)
sudo pmset -a powernap 0

# Lid wake'i etkinlestir
sudo pmset -a lidwake 1

# Guc kaybinda otomatik yeniden baslat
sudo pmset -a autorestart 1

# Sleep image dosyasini kaldir (disk alani tasarrufu)
sudo rm -f /private/var/vm/sleepimage 2>/dev/null || true
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage

success "SSD & energy settings configured"

###############################################################################
# Keyboard and input                                                          #
###############################################################################

step "Configuring keyboard and input"

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Tus tekrar hizini maksimuma cikar (vim/terminal icin)
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Press-and-hold'u devre disi birak (tus tekrari icin)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fn tusunu Globe yerine Fn olarak kullan
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Klavye duzenleri: Turkish Q + US English
# Not: Bu ayar bazen login/restart sonrasi aktif olur
defaults write com.apple.HIToolbox AppleEnabledInputSources -array \
    '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>0</integer><key>KeyboardLayout Name</key><string>U.S.</string></dict>' \
    '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>17925</integer><key>KeyboardLayout Name</key><string>Turkish-QWERTY-PC</string></dict>'

# Input source degistirme: Ctrl+Space (varsayilan)
# 60 = Select previous input source
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'

success "Keyboard and input configured"

###############################################################################
# Timezone & Locale - TURKEY                                                  #
###############################################################################

step "Configuring timezone & locale for Turkey"

# Timezone - Istanbul
sudo systemsetup -settimezone "Europe/Istanbul" > /dev/null

# Dil - Turkce oncelikli, Ingilizce yedek
defaults write NSGlobalDomain AppleLanguages -array "tr" "en"
defaults write NSGlobalDomain AppleLocale -string "tr_TR@currency=TRY"

# Olcu birimleri - Metrik
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Sayi formati - Turkiye (1.234,56)
defaults write NSGlobalDomain AppleICUNumberSymbols -dict 0 "," 1 "." 10 "," 17 "."

# 24 saat formati
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Hafta Pazartesi baslasin
defaults write NSGlobalDomain AppleFirstWeekday -dict gregorian 2

success "Timezone & locale configured"

###############################################################################
# Screen                                                                      #
###############################################################################

step "Configuring screen settings"

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

success "Screen settings configured"

###############################################################################
# Trackpad                                                                    #
###############################################################################

step "Configuring trackpad"

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Three finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Tracking speed (0-3, default 1)
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

# Natural scrolling (true = natural, false = traditional)
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Right click with two fingers
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

success "Trackpad configured"

###############################################################################
# Hot Corners                                                                 #
###############################################################################

step "Configuring hot corners"

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen

# Top left: Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right: Notification Center
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left: Desktop
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right: Lock Screen
defaults write com.apple.dock wvous-br-corner -int 13
defaults write com.apple.dock wvous-br-modifier -int 0

success "Hot corners configured"

###############################################################################
# Menu Bar                                                                    #
###############################################################################

step "Configuring menu bar"

# Battery: show percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Clock: show date and seconds
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss"

# Menu bar: show Bluetooth
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true

success "Menu bar configured"

###############################################################################
# Accessibility                                                               #
###############################################################################

step "Configuring accessibility"

# Note: These settings require manual change in System Settings > Accessibility
# due to SIP protection. Uncomment if you have accessibility permissions.
# defaults write com.apple.universalaccess reduceTransparency -bool true
# defaults write com.apple.universalaccess reduceMotion -bool true

warn "Accessibility settings require manual configuration in System Settings"

###############################################################################
# Finder                                                                      #
###############################################################################

step "Configuring Finder"

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# USB surculerde .DS_Store olusturma
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Klasorleri her zaman once goster
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Path bar'i goster
defaults write com.apple.finder ShowPathbar -bool true

# Status bar'i goster
defaults write com.apple.finder ShowStatusBar -bool true

# Cop kutusunu 30 gun sonra otomatik bosalt
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Airdrop'u her yerde etkinlestir
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the ~/Users folder
chflags nohidden /Users

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

success "Finder configured"

###############################################################################
# Screenshots                                                                 #
###############################################################################

step "Configuring screenshots"

# Screenshots klasoru olustur
mkdir -p "${HOME}/Screenshots"

# Screenshot konumu
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Exclude date and time in screenshot filenames
defaults write com.apple.screencapture "include-date" -bool false

# Change the default screenshot file name
defaults write com.apple.screencapture "name" -string "screenshot"

# Screenshot'lardan shadow'u kaldir (clean screenshots)
defaults write com.apple.screencapture disable-shadow -bool true

# Screenshot formatı (png, jpg, gif, pdf, tiff)
defaults write com.apple.screencapture type -string "png"

success "Screenshot settings configured"

###############################################################################
# Dock                                                                         #
###############################################################################

step "Configuring Dock"

# Prevent applications from bouncing in Dock
defaults write com.apple.dock no-bouncing -bool true

# Set the icon size of Dock items to 72 pixels
defaults write com.apple.dock tilesize -int 72

# Hide indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool false

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don't use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array ""

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Son kullanilan uygulamalari gosterme
defaults write com.apple.dock show-recents -bool false

# Minimize efektini scale olarak ayarla (genie yerine)
defaults write com.apple.dock mineffect -string "scale"

success "Dock configured"

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

step "Configuring Safari"

# Enable Safari's debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

success "Safari configured"

###############################################################################
# App Store                                                                   #
###############################################################################

step "Configuring App Store settings"

# App Store debug menüsünü aç
defaults write com.apple.appstore ShowDebugMenu -bool true

# Otomatik güncelleme kontrolü
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Haftalık güncelleme kontrolü
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 7

success "App Store configured"

###############################################################################
# Photos                                                                      #
###############################################################################

step "Configuring Photos settings"

# Photos'un iPhone bağlandığında açılmasını engelle
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

success "Photos configured"

###############################################################################
# Mail                                                                        #
###############################################################################

step "Configuring Mail settings"

# E-posta adreslerini sadece adres olarak kopyala (isim olmadan)
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Inline attachment'ları devre dışı bırak
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

success "Mail configured"

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

step "Configuring Activity Monitor"

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

success "Activity Monitor configured"

###############################################################################
# TextEdit                                                                     #
###############################################################################

step "Configuring TextEdit"

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

success "TextEdit configured"

###############################################################################
# Messages                                                                    #
###############################################################################

step "Configuring Messages"

# Disable smart quotes as it's annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

success "Messages configured"

###############################################################################
# Terminal & Developer Tools                                                  #
###############################################################################

step "Configuring developer tools"

# Xcode - build surelerini goster
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true

# Simulator - ekran goruntusu konumu
defaults write com.apple.iphonesimulator ScreenShotSaveLocation -string "${HOME}/Desktop"

success "Developer tools configured"

###############################################################################
# Security                                                                    #
###############################################################################

step "Configuring security settings"

# Firewall'i etkinlestir
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Stealth mode (ping'lere cevap verme)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

success "Security settings configured"

###############################################################################
# Apply changes                                                               #
###############################################################################

step "Restarting affected applications"

for app in "Activity Monitor" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Mail" "Messages" "Photos" "Safari" "SystemUIServer"; do
	killall "${app}" &> /dev/null || true
done

echo ""
success "macOS defaults configured!"
echo ""
warn "Some changes require a logout/restart to take effect."
echo ""
echo "Manual steps required:"
echo "  - Apple Intelligence'i kapat: System Settings > Apple Intelligence & Siri"
echo "  - Spotlight exclusions: See macos/spotlight-exclude.md"
echo ""
