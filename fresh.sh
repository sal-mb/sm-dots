#!/bin/bash

echo "updating packages"
sudo pacman -Syuu

# Check if paru is installed
if ! command -v paru &> /dev/null; then
  echo "paru is not installed. Installing paru..."
  sudo pacman -S --noconfirm paru
else
  echo "paru is already installed."
fi

# Install zoxide, helix, and wezterm using paru
echo "Installing terminal tools..."
paru -S --noconfirm zoxide helix wezterm yazi lsd

echo "Installing hyprland packages..."
paru -S --noconfirm hyprland hyprpolkitagent ironbar-git pipewire wireplumber

echo "Installation complete!"

