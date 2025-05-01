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
mkdir -p ~/.config/hypr
cp -r ./hypr ~/.config/
cp -r ./rofi ~/.config/
cp -r ./waybar ~/.config/
cp -r ./scripts/* ~/.config/hypr/

# Restore launch scripts and desktop files
mkdir -p ~/.local/bin/office-apps
cp -r ./office-scripts/* ~/.local/bin/office-apps/
chmod +x ~/.local/bin/office-apps/*.sh

mkdir -p ~/.local/share/applications
cp -r ./app-launchers/*.desktop ~/.local/share/applications/

# Restore shell settings
echo "🔁 Restoring shell configs..."
cp -n .zshrc ~/.zshrc || echo "ℹ️  Skipped .zshrc, already exists."
cp -n .bashrc ~/.bashrc || echo "ℹ️  Skipped .bashrc, already exists."

# Restore wallpapers (optional)
if [ -d ./wallpapers ]; then
  mkdir -p ~/.wallpapers
  cp -r ./wallpapers/* ~/.wallpapers/
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

# Chrome check
if ! command -v google-chrome &> /dev/null; then
  echo "⚠️  Google Chrome is not installed. Office Web Apps may not work!"
  echo "    Download: https://www.google.com/chrome/"
fi

# Reload desktop apps
update-desktop-database ~/.local/share/applications

echo "🎉 Setup complete! Restart Hyprland or log out/in to apply changes."
