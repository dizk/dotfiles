#!/bin/bash

#
# User calling the script
#
[ $SUDO_USER ] && USER=$SUDO_USER || USER=`whoami`
USER_HOME=$(sudo -u $USER sh -c 'echo $HOME')
OH_MY_ZSH="$USER_HOME/.oh-my-zsh"
DOTFILES="$USER_HOME/.dotfiles"


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
if [ ! -d "$DOTFILES" ]; then
    echo "Initializing dotfiles..."
    sudo -u $USER /usr/bin/git clone --bare https://github.com/dizk/dotfiles.git $DOTFILES
    sudo -u $USER /usr/bin/git --git-dir=$DOTFILES --work-tree=$USER_HOME checkout
else 
    echo "Updating dotfiles..."
    sudo -u $USER /usr/bin/git --git-dir=$DOTFILES --work-tree=$USER_HOME pull
fi

#
# Install oh-my-zsh
#
if [ ! -d "$OH_MY_ZSH" ]; then
    echo "Installing oh-my-zsh..."
    sudo -u $USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

#
# Install custom oh-my-zsh plugins
#
ZSH_NVM=$OH_MY_ZSH/custom/plugins/zsh-nvm
if [ ! -d "$ZSH_NVM" ]; then
    echo "Installing zsh-nvm plugin..."
    sudo -u $USER git clone https://github.com/lukechilds/zsh-nvm $ZSH_NVM
fi

#
# Change default shell for user
#
chsh -s $(which zsh) $USER

echo "OK! Close this teminal and open a new one ;)"