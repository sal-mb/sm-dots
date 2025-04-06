#!/bin/bash

# echo "updating packages"
# sudo pacman -Syuu --noconfirm

# # Check if paru is installed
# if ! command -v paru &> /dev/null; then
#   echo "paru is not installed. Installing paru..."
#   sudo pacman -S --noconfirm paru
# else
#   echo "paru is already installed."
# fi

# echo "Installing network tools..."
# paru -S --noconfirm dialog networkmanager network-manager-applet wireless_tools

# # Install zoxide, helix, and wezterm using paru
# echo "Installing terminal tools..."
# paru -S --noconfirm zoxide helix wezterm yazi lsd fish fisher tealdeer bear 

# echo "Installing hyprland packages..."
# #paru -S --noconfirm hyprland hyprpolkitagent ironbar-git pipewire wireplumber brightnessctl greetd-tuigreet dunst libnotify

# echo "Installing fonts..."
# paru -S --noconfirm ttf-font-awesome ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols

# echo "Installing gtk themes..."
# paru -S --noconfirm nwg-look papirus-icon-theme materia-gtk-theme

# echo "Installing qt themes..."
# paru -S --noconfirm kvantum-qt6-git kvantum-theme-materia

# Prompt for laptop power packages installation
read -p "Do you want to install laptop power packages (powertop and acpi)? [y/n]: " install_laptop_power
if [[ "$install_laptop_power" == "y" || "$install_laptop_power" == "Y" ]]; then
  echo "Installing laptop power packages..."
  paru -S --noconfirm powertop acpi

  echo "Setting powertop service..."
  read -p "Do you want to calibrate powertop? (takes a long time, your screen may turn black for a while so don't panic) [y/n]: " calibrate_powertop

  if [[ "$calibrate_powertop" == "y" || "$install_laptop_power" == "Y" ]]; then
    echo "Calibrating powertop..."
    sudo powertop -c
  fi

  echo "Enabling powertop service"
  sudo ln -s ~/sm-dots/powertop.service /etc/systemd/system/
  sudo systemctl enable powertop.service
else
  echo "Skipping laptop power packages installation."
fi

echo "Enabling greetd manager service..."
sudo systemctl enable greetd.service

echo "Installation complete!"

echo "Creating symlinks..."
rm -rf ~/.config/fish
ln -snf ~/sm-dots/.config/fish ~/.config/fish
rm -rf ~/.config/helix
ln -snf ~/sm-dots/.config/helix ~/.config/helix
rm -rf ~/.config/yazi
ln -snf ~/sm-dots/.config/yazi ~/.config/yazi
rm -f ~/.wezterm.lua
ln -s ~/sm-dots/.wezterm.lua ~/.wezterm.lua
rm -rf ~/.config/ironbar
ln -snf ~/sm-dots/.config/ironbar ~/.config/ironbar
sudo rm -rf /etc/greetd/config.toml
sudo ln -s ~/sm-dots/config.toml /etc/greetd/
