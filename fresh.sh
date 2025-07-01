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
read -p "Do you want to install wireless packages? [y/N]: " install_wireless
if [[ "$install_wireless" == "y" || "$install_wireless" == "Y" ]]; then
 paru -S --noconfirm wireless_tools
fi
 paru -S --noconfirm networkmanager
 sudo systemctl enable NetworkManager.service

 echo "Installing utils..."
 paru -S --noconfirm zip pipewire wireplumber brightnessctl libnotify gnome-disk-utility gvfs ntfs-3g 7zip blueman

 echo "Installing terminal tools..."
 paru -S --noconfirm zoxide helix wezterm yazi lsd fish fisher tealdeer bear fd 

 echo "Installing hyprland packages..."
 paru -S --noconfirm hyprland hyprpaper hyprpolkitagent ironbar-git greetd-tuigreet dunst hyprlock hypridle hyprshade-git wlsunset zen-browser fuzzel

 echo "Installing screenshot tools..."
 paru -S --noconfirm grim slurp swappy

 echo "Installing fonts..."
 paru -S --noconfirm ttf-font-awesome ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols

 echo "Installing gtk themes..."
 paru -S --noconfirm python-yapsy-git gradience nwg-look papirus-icon-theme materia-gtk-theme adw-gtk-theme

 echo "Installing qt themes..."
 paru -S --noconfirm kvantum-qt6-git kvantum-theme-materia qt5-wayland qt6-wayland qt5ct qt6ct

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
rm -f ~/.gitconfig
ln -s ~/sm-dots/.gitconfig ~/.gitconfig
rm -rf ~/.config/ironbar
ln -snf ~/sm-dots/.config/ironbar ~/.config/ironbar
rm -rf ~/.config/dunst 
ln -snf ~/sm-dots/.config/dunst ~/.config/dunst
rm -rf ~/.config/fuzzel 
ln -snf ~/sm-dots/.config/fuzzel ~/.config/fuzzel
rm -rf ~/.config/hypr
ln -snf ~/sm-dots/.config/hypr ~/.config/hypr
rm -rf ~/.config/Kvantum
ln -snf ~/sm-dots/.config/Kvantum ~/.config/Kvantum
rm -rf ~/.config/gtk-3.0
ln -snf ~/sm-dots/.config/gtk-3.0 ~/.config/gtk-3.0
rm -rf ~/.config/gtk-4.0
ln -snf ~/sm-dots/.config/gtk-4.0 ~/.config/gtk-4.0
rm -rf ~/.config/qt5ct
ln -snf ~/sm-dots/.config/qt5ct ~/.config/qt5ct
rm -rf ~/.config/qt6ct
ln -snf ~/sm-dots/.config/qt6ct ~/.config/qt6ct
rm -f ~/.config/mimeapps.list
ln -s ~/sm-dots/.config/mimeapps.list ~/.config/mimeapps.list
sudo rm -rf /etc/greetd/config.toml
sudo ln -s ~/sm-dots/config.toml /etc/greetd/

mkdir ~/Pictures/wallpapers
cp ~/sm-dots/wp.png ~/Pictures/wallpapers/
