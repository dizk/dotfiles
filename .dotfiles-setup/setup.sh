#!/bin/bash

#
# User calling the script
#
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
user_home=$(sudo -u $user sh -c 'echo $HOME')

#
# Install packages
#
apt install -y \
    git \
    zsh 

#
# Clone dotfiles
#
sudo -u $user /usr/bin/git clone --bare https://github.com/dizk/dotfiles.git $user_home/.dotfiles
sudo -u $user /usr/bin/git --git-dir=$user_home/.dotfiles/ --work-tree=$user_home checkout
# Alias dotfiles is defined in the downloaded dotfiles

#
# Install oh-my-zsh
#
if [ ! -d "$user_home/.oh-my-zsh" ]; then
    sudo -u $user sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


echo "OK! Close this teminal and open a new one ;)"