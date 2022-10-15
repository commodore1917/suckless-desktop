#!/bin/bash

if [[ $EUID = 0 ]]; then
   echo "This script must NOT be run as root." 1>&2
   exit 1
fi

echo ""
echo "**************************************************"
echo "**   Alpine Linux Suckless Desktop Installer    **"
echo "**************************************************"
echo ""

USERNAME=$(whoami)

# Configuring environment
echo "Configuring environment..."
doas setup-xorg-base
doas adduser $USERNAME input
doas adduser $USERNAME audio
doas adduser $USERNAME video
doas addgroup $USERNAME audio
doas addgroup root audio
doas rc-service sshd stop
doas rc-update del sshd

# Install dependencies [font-awesome?]
echo "Installing dependencies..."
doas apk -U upgrade
doas apk add git make gcc linux-headers g++ libx11-dev libxft-dev libxinerama-dev ncurses dbus-x11 adwaita-icon-theme ttf-dejavu xrandr libxrandr-dev xautolock xcompmgr bsd-compat-headers alsa-utils alsa-lib alsa-utils-doc alsaconf alsa-ucm-conf feh
rc-service alsa start
rc-update add alsa

# Install utilities
echo "Installing utilities..."
doas apk add wget curl vim mpv sxiv mupdf #firefox

# Build suckless tools
echo "Building suckless tools..."
for folder in dwm/ dmenu/ st/ slock/ slstatus/ scroll/
do
    cd $folder
    make
    doas make install
    cd ..
done

# Build other tools
echo "Building other tools..."
	
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
echo "startx" >> $HOME/.profile
mv dotfiles/.bashrc $HOME/.bashrc
mv dotfiles/.vimrc $HOME/.vimrc

# Deploy wallpapers
echo "Deploying wallpapers..."
mkdir $HOME/.wallpapers
cp wallpapers/* $HOME/.wallpapers/

# Deploy sounds
echo "Deploying sounds..."
cp sounds/* /usr/share/sounds

# Copy scripts to /usr/bin/
echo "Copying scripts to /usr/bin/..."
doas cp scripts/* /usr/bin/

# Start desktop
startx

