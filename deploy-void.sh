#!/bin/bash

if [[ $EUID = 0 ]]; then
   echo "This script must NOT be run as root." 1>&2
   exit 1
fi

# Exit on errors
set -e

echo ""
echo "************************************************"
echo "**   Void linux Suckless Desktop Installer    **"
echo "************************************************"
echo ""

# Check if doas is installed
if ! command -v doas &> /dev/null
then
    # Update
    sudo xbps-install -Syu
    # Install doas
    echo "doas could not be found"
    echo "Installing doas..."
    USERNAME=$(whoami)
    sudo xbps-install -Syu opendoas 
    sudo bash -c "echo \"permit persist :wheel\" > /etc/doas.conf"
    sudo usermod -a -G wheel $USERNAME
    sudo bash -c "echo \"ignorepkg=sudo\" > /etc/xbps.d/ignoresudo.conf"
    doas xbps-remove -Ry sudo   
    doas ln -s /bin/doas /bin/sudo
fi

# Update
echo "Updating..."
doas xbps-install -Syu

# Install dependencies [font-awesome?]
echo "Installing dependencies..."
doas xbps-install -Syu xorg-minimal xorg-fonts base-devel libXau-devel libXdmcp-devel libxcb-devel libX11-devel libXext-devel libXinerama-devel libXrender-devel libXft-devel libXrandr-devel libpng xrandr xautolock xcompmgr freetype-devel fontconfig alsa-utils feh git void-repo-nonfree tiramisu

# Install utilities
echo "Installing utilities..."
doas xbps-install -Syu wget curl vim mpv sxiv mupdf #firefox

# Build suckless tools
echo "Building suckless tools..."
for folder in dwm/ dmenu/ st/ slock/ slstatus/
do
    cd $folder
    make
    doas make install
    make clean
    cd ..
done

# Build SFM (file manager)
git clone https://github.com/afify/sfm
cd sfm/
make
doas make install
cd ..
rm -rf sfm/

# Get VIM resources
mkdir $HOME/.vim
mkdir $HOME/.vim/colors
curl -o $HOME/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Deploy dotfiles
echo "Deploying dotfiles..."
cat dotfiles/.xinitrc >> $HOME/.xinitrc
echo "startx" >> $HOME/.bash_profile
mv dotfiles/.bashrc $HOME/.bashrc
mv dotfiles/.vimrc $HOME/.vimrc

# Deploy wallpapers
mkdir $HOME/.wallpapers
cp wallpapers/* $HOME/.wallpapers/

# Deploy sounds
cp sounds/* /usr/share/sounds

# Copy scripts to /usr/bin/
echo "Copying scripts to /usr/bin/..."
chmod +x scripts/*
doas cp scripts/* /usr/bin/

# Laptop battery
# sudo xbps-install -Sy tlp
# sudo ln -s /etc/sv/tlp /var/service/

# Bluetooth https://docs.voidlinux.org/config/bluetooth.html
# sudo xbps-install -Sy bluez
# sudo ln -s /etc/sv/dbus /var/service/
# sudo ln -s /etc/sv/bluetoothd /var/service/
# sv restart dbus

# Start desktop
startx
