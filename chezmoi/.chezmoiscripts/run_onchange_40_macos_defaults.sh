#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
  exit 0
fi

# Finder and global preferences

defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.loginwindow GuestEnabled -bool false

defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Dock preferences

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 42
defaults write com.apple.dock static-only -bool true

# Dock items (if dockutil is available)
if command -v dockutil >/dev/null 2>&1; then
  dockutil --remove all --no-restart || true
  add_dock_item() {
    local app_path="$1"
    if [ -d "$app_path" ]; then
      dockutil --add "$app_path" --no-restart
    else
      echo "Dock item not found: $app_path" >&2
    fi
  }

  add_dock_item "/Applications/Notion.app"
  add_dock_item "/System/Applications/Calendar.app"
  add_dock_item "/Applications/Ghostty.app"
  add_dock_item "/Applications/Helium.app"
  add_dock_item "/Applications/Zen.app"
fi

# Symbolic hotkeys
plist="$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"
if [ ! -f "$plist" ]; then
  /usr/bin/defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict >/dev/null 2>&1 || true
fi

plistbuddy="/usr/libexec/PlistBuddy"

ensure_key() {
  local key="$1"
  if ! $plistbuddy -c "Print :AppleSymbolicHotKeys:$key" "$plist" >/dev/null 2>&1; then
    $plistbuddy -c "Add :AppleSymbolicHotKeys:$key dict" "$plist"
  fi
  if ! $plistbuddy -c "Print :AppleSymbolicHotKeys:$key:value" "$plist" >/dev/null 2>&1; then
    $plistbuddy -c "Add :AppleSymbolicHotKeys:$key:value dict" "$plist"
  fi
  if ! $plistbuddy -c "Print :AppleSymbolicHotKeys:$key:value:parameters" "$plist" >/dev/null 2>&1; then
    $plistbuddy -c "Add :AppleSymbolicHotKeys:$key:value:parameters array" "$plist"
  fi
}

set_hotkey() {
  local key="$1"
  local enabled="$2"
  local p0="$3"
  local p1="$4"
  local p2="$5"

  ensure_key "$key"

  if $plistbuddy -c "Print :AppleSymbolicHotKeys:$key:enabled" "$plist" >/dev/null 2>&1; then
    $plistbuddy -c "Set :AppleSymbolicHotKeys:$key:enabled $enabled" "$plist"
  else
    $plistbuddy -c "Add :AppleSymbolicHotKeys:$key:enabled bool $enabled" "$plist"
  fi

  if $plistbuddy -c "Print :AppleSymbolicHotKeys:$key:value:type" "$plist" >/dev/null 2>&1; then
    $plistbuddy -c "Set :AppleSymbolicHotKeys:$key:value:type standard" "$plist"
  else
    $plistbuddy -c "Add :AppleSymbolicHotKeys:$key:value:type string standard" "$plist"
  fi

  if $plistbuddy -c "Print :AppleSymbolicHotKeys:$key:value:parameters:0" "$plist" >/dev/null 2>&1; then
    $plistbuddy -c "Set :AppleSymbolicHotKeys:$key:value:parameters:0 $p0" "$plist"
  else
    $plistbuddy -c "Add :AppleSymbolicHotKeys:$key:value:parameters:0 integer $p0" "$plist"
  fi

  if $plistbuddy -c "Print :AppleSymbolicHotKeys:$key:value:parameters:1" "$plist" >/dev/null 2>&1; then
    $plistbuddy -c "Set :AppleSymbolicHotKeys:$key:value:parameters:1 $p1" "$plist"
  else
    $plistbuddy -c "Add :AppleSymbolicHotKeys:$key:value:parameters:1 integer $p1" "$plist"
  fi

  if $plistbuddy -c "Print :AppleSymbolicHotKeys:$key:value:parameters:2" "$plist" >/dev/null 2>&1; then
    $plistbuddy -c "Set :AppleSymbolicHotKeys:$key:value:parameters:2 $p2" "$plist"
  else
    $plistbuddy -c "Add :AppleSymbolicHotKeys:$key:value:parameters:2 integer $p2" "$plist"
  fi
}

# Show Launchpad -> Command + Option + L
set_hotkey 160 true 108 37 1572864
# Disable Show Desktop with F11
set_hotkey 36 false 65535 103 8388608
set_hotkey 37 false 65535 103 8519680

killall cfprefsd >/dev/null 2>&1 || true
killall Dock >/dev/null 2>&1 || true
killall Finder >/dev/null 2>&1 || true
killall SystemUIServer >/dev/null 2>&1 || true
