#!/bin/bash

 echo "updating packages"
 sudo pacman -Syuu --noconfirm

 # Check if paru is installed
 if ! command -v paru &> /dev/null; then
   echo "paru is not installed. Installing paru..."
   sudo pacman -S --noconfirm paru
 else
   echo "paru is already installed."
 fi

 echo "Installing network tools..."
read -p "Do you want to install iwd instead of networkmanager? (not recommended) [y/N]: " install_iwd
if [[ "$install_iwd" == "y" || "$install_iwd" == "Y" ]]; then
  paru -S --nocofirm iwd impala wireless_tools
  sudo systemctl disable NetworkManager.service
  sudo systemctl enable iwd.service
  sudo mkdir /etc/iwd
  ln -s ~/sm-dots/main.conf /etc/iwd
else
 paru -S --noconfirm networkmanager network-manager-applet wireless_tools
 sudo systemctl enable NetworkManager.service
fi

 # Install zoxide, helix, and wezterm using paru
 echo "Installing terminal tools..."
 paru -S --noconfirm zoxide helix wezterm yazi lsd fish fisher tealdeer bear fd zip

 echo "Installing hyprland packages..."
 paru -S --noconfirm hyprland hyprpolkitagent ironbar-git pipewire wireplumber brightnessctl greetd-tuigreet dunst libnotify hyprlock hypridle hyprshade-git wlsunset zen-browser

 echo "Installing screenshot tools..."
 paru -S --noconfirm grim slurp swappy

 echo "Installing fonts..."
 paru -S --noconfirm ttf-font-awesome ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols

 echo "Installing gtk themes..."
 paru -S --noconfirm nwg-look papirus-icon-theme materia-gtk-theme

 echo "Installing qt themes..."
 paru -S --noconfirm kvantum-qt6-git kvantum-theme-materia qt5-wayland qt6-wayland

# Prompt for laptop power packages installation
read -p "Do you want to install laptop power packages (tlp and acpi)? [y/N]: " install_laptop_power
if [[ "$install_laptop_power" == "y" || "$install_laptop_power" == "Y" ]]; then
  echo "Installing laptop power packages..."
  paru -S --noconfirm tlp acpi

  sudo systemctl enable tlp.service

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
rm -rf ~/.config/dunst 
ln -snf ~/sm-dots/.config/dunst ~/.config/dunst
rm -rf ~/.config/fuzzel 
ln -snf ~/sm-dots/.config/fuzzel ~/.config/fuzzel
sudo rm -rf /etc/greetd/config.toml
sudo ln -s ~/sm-dots/config.toml /etc/greetd/
