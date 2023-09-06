#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Update mirror list
echo "Updating pacman mirrors"
pacman-mirrors --fasttrack

# Update the system and refresh package lists
echo "Updating system and refreshing package lists..."
pacman -Syyu --noconfirm

# Install essential packages
echo "Installing pacman essential packages..."
pacman -S --noconfirm base-devel texlive-basic texlive-bibtexextra \
    texlive-langspanish texlive-fontsextra texlive-fontsrecommeded \
    texlive-fontutils cargo nvm python-pip neovim snapd steam
 
# Echo things to .zshrc
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc

# Source scripts
source /usr/share/nvm/init-nvm.sh

# Secondary installs and config
echo "Secondary installs..."
nvm install 20
rustup default stable


# Enable and start system services
echo "Enabling and starting services..."
systemctl enable snapd.service
systemctl start snapd.service

# Configure system settings
echo "Configuring system settings..."



# Install additional software
echo "Installing additional software..."
yay -S 

# Configure user settings
echo "Configuring user settings..."
# Add user-specific configuration here if needed

# Clean up
echo "Cleaning up..."
pacman -Qdtq | pacman -Rns - --noconfirm
pacman -Sc --noconfirm

echo "Setup completed successfully."

