#!/bin/bash

# Changes the delay when dragging windows off the edge of the screen to other spaces. Default value is 0.75.
defaults write com.apple.dock workspaces-edge-delay -float 0.5

# Makes all items in the Dock spring loaded. For example, hold a file over an application and it will open or come to the front so you can drop the file onto a specific window. Repeat with NO to reverse.
defaults write com.apple.dock enable-spring-load-actions-on-all-items -boolean YES


# defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES

# sudo defaults write /System/Library/LaunchDaemons/com.apple.backupd-auto StartInterval -int 7200

defaults write -g NSNavPanelExpandedStateForSaveMode -bool TRUE
