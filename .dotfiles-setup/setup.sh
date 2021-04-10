#!/bin/bash

#
# User calling the script
#
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
user_home=$(sudo -u $user sh -c 'echo $HOME')

#
# Install packages
#
echo "Running apt install..."
apt install -y \
    git \
    zsh 

#
# Clone dotfiles
#
if [ ! -d "$user_home/.dotfiles" ]; then
    echo "Initializing dotfiles..."
    sudo -u $user /usr/bin/git clone --bare https://github.com/dizk/dotfiles.git $user_home/.dotfiles
    sudo -u $user /usr/bin/git --git-dir=$user_home/.dotfiles/ --work-tree=$user_home checkout
else 
    echo "Updating dotfiles..."
    sudo -u $user /usr/bin/git --git-dir=$user_home/.dotfiles/ --work-tree=$user_home pull
fi

#
# Install oh-my-zsh
#
if [ ! -d "$user_home/.oh-my-zsh" ]; then
    sudo -u $user sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

#
# Change default shell for user
#
sudo -u $user chsh -s $(which zsh)

echo "OK! Close this teminal and open a new one ;)"