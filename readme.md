#!/bin/bash

# Hyprland Dotfiles Setup Script by Dempaman

# 💫 Clones your dotfiles and restores them, including dependencies

set -e

DOTFILES_REPO="https://github.com/Dempaman/hyprland-dotfiles.git"
TARGET_DIR="$HOME/dotfiles"

# Clone repo if it doesn't exist

if [ ! -d "$TARGET_DIR" ]; then
echo "📦 Cloning dotfiles repo..."
git clone "$DOTFILES_REPO" "$TARGET_DIR"
else
echo "✅ Dotfiles directory already exists at $TARGET_DIR"
fi

cd "$TARGET_DIR"

# Restore config files

echo "🔧 Copying config files..."
cp -r ./hypr ~/.config/
cp -r ./rofi ~/.config/
cp -r ./waybar ~/.config/
cp -r ./scripts ~/.config/hypr/

# Restore launch scripts and desktop files

mkdir -p ~/.local/bin/office-apps
cp -r ./office-scripts/_ ~/.local/bin/office-apps/
chmod +x ~/.local/bin/office-apps/_.sh

mkdir -p ~/.local/share/applications
cp -r ./app-launchers/\*.desktop ~/.local/share/applications/

# Restore shell settings

echo "🔁 Restoring shell configs..."
cp .zshrc ~/
cp .bashrc ~/

# Restore wallpapers (optional)

if [ -d ./wallpapers ]; then
mkdir -p ~/.wallpapers
cp -r ./wallpapers/\* ~/.wallpapers/
fi

# Install basic dependencies

echo "📦 Installing required packages..."
sudo apt update && sudo apt install -y \
 jq \
 zsh \
 git \
 curl \
 unzip \
 wget \
 rofi \
 kitty \
 fonts-jetbrains-mono \
 fonts-iosevka \
 lxappearance \
 imagemagick \
 hyprland \
 waybar \
 swaybg \
 wl-clipboard \
 xdg-desktop-portal-hyprland

# Chrome reminder

echo "⚠️ NOTE: Google Chrome is required for Office Web Apps. Please install it manually from:"
echo " https://www.google.com/chrome/"

# Reload desktop apps

update-desktop-database ~/.local/share/applications

echo "🎉 Setup complete! Restart Hyprland or log out/in to apply changes."
