# Use F1, F2... as standard function keys
defaults write "Apple Global Domain" "com.apple.keyboard.fnState" "1"

# Import customized keyboard shortcuts
defaults import com.apple.symbolichotkeys ~/.dotfiles/macos/settings/symbolichotkeys.plist

# Specify the preferences directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm2/settings"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Autohide dock
defaults write com.apple.Dock autohide "1"
