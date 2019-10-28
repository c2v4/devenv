#!/bin/bash

echo -n "Updating the package list"
apt-get update -y
apt-get upgrade -y

echo -n "Installing Xubuntu and Ubuntu session"
apt-get install -y xubuntu-desktop
apt-get install -y ubuntu-session

echo -n "Installing virtualbox guest additions"
apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 linux-headers-$(uname -r)

echo -n "Installing Java 8"
apt-get install -y default-jdk

echo -n "Installing Intellij"
apt-get install -y snapd
#snap install intellij-idea-ultimate --classic

echo -n "Installing tooling"
apt-get install -y tilix yadm fasd git

echo -n "Installing ZSH"
apt-get install -y zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#git clone https://github.com/zsh-users/antigen.git
#chown -R vagrant:vagrant antigen
chsh -s $(which zsh) vagrant

su -c 'ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa' vagrant
su -c 'yadm clone --recurse-submodules -j8 https://github.com/c2v4/dotfiles' vagrant
