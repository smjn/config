#!/bin/bash
#work in progress
sudo su
apt-get clean
apt-get autoclean
apt-get autoremove
add-apt-repository -y ppa:gnome-terminator/ppa
add-apt-repository -y ppa:videolan/stable-daily  
add-apt-repository -y ppa:nathan-renniewaldock/flux
add-apt-repository -y ppa:numix/ppa
add-apt-repository -y ppa:webupd8team/java
pref=/etc/apt/sources.list.d
for i in $(ls $pref)
do
	sed -i 's/jessie/xenial/g' $pref/$i
done
sh -c 'echo "deb http://download.opensuse.org/repositories/home:/Horst3180/Debian_8.0/ /" > /etc/apt/sources.list.d/vertex-theme.list'

apt-get update
apt-get -y install vlc smplayer mplayer zsh terminator ranger bmon iftop htop lshw lm-sensors vim numix-gtk-theme vertex-theme numix-icon-theme-circle clementine oracle-java8-installer build-essential openvpn

cd /media/dumps/linux-setups

dpkg -i google-chrome-stable_current_amd64.deb
dpkg -i sublime-text_build-3114_amd64.deb
dpkg -i unetbootin_585-2ubuntu1_amd64.deb
apt-get -f install
