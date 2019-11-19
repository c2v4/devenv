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
snap install intellij-idea-ultimate --classic

echo -n "Installing Node"
snap install node --channel=13/stable --classic

echo -n "Installing Docker and Kubernetes"
apt-get install -y docker docker-compose
#sudo snap install microk8s --classic
usermod -aG docker vagrant

echo -n "Installing tooling"
apt-get install -y tilix yadm fasd git maven

echo -n "Configuring autologin"
echo "[Seat:*]
autologin-guest=false
autologin-user=vagrant
autologin-user-timeout=0" >/etc/lightdm/lightdm.conf.d/autologin.conf

echo -n "Installing ZSH"
apt-get install -y zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#git clone https://github.com/zsh-users/antigen.git
#chown -R vagrant:vagrant antigen
chsh -s $(which zsh) vagrant

su -c 'ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa' vagrant
su -c 'yadm clone https://github.com/c2v4/dotfiles' vagrant
su -c 'yadm submodule update --init --recursive' vagrant
