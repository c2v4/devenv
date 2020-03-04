#!/bin/bash
echo -n "Installing apt-fast"
/bin/bash -c "$(curl -sL https://git.io/vokNn)"
alias apt-get='apt-fast'

echo -n "Updating the package list"
apt-fast update -y
apt-fast upgrade -y

echo -n "Installing Xubuntu and Ubuntu session"
apt-fast install -y xubuntu-desktop ubuntu-session

echo -n "Installing virtualbox guest additions"
apt-fast install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 linux-headers-$(uname -r)

echo -n "Installing Java 8"
apt-fast install -y default-jdk

echo -n "Installing Intellij"
apt-fast install -y snapd ubuntu-make
#snap install intellij-idea-ultimate --classic
umake ide idea-ultimate ~/.idea
ln -sf /home/vagrant/.idea/bin/idea.sh /usr/sbin/idea

echo -n "Installing Node"
snap install node --channel=13/stable --classic &

echo -n "Installing Docker and Kubernetes"
apt-fast install -y docker docker-compose
#sudo snap install microk8s --classic
usermod -aG docker vagrant

echo -n "Installing tooling"
apt-fast install -y tilix yadm fasd git maven tmux

echo -n "Installing kitty"
su -c 'curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n' vagrant

echo -n "Configuring autologin"
echo "[Seat:*]
autologin-guest=false
autologin-user=vagrant
autologin-user-timeout=0" >/etc/lightdm/lightdm.conf.d/autologin.conf

echo -n "Installing ZSH"
apt-fast install -y zsh lcov ctop
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#git clone https://github.com/zsh-users/antigen.git
#chown -R vagrant:vagrant antigen
chsh -s $(which zsh) vagrant

su -c 'ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa' vagrant
su -c 'yadm clone https://github.com/c2v4/dotfiles' vagrant
su -c 'yadm submodule update --init --recursive' vagrant

wait
apt-fast clean
