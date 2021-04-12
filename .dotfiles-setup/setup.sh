#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#
# User calling the script
#
[ $SUDO_USER ] && USER=$SUDO_USER || USER=`whoami`
USER_HOME=$(sudo -u $USER sh -c 'echo $HOME')
SETUP_FOLDER="$USER_HOME/.dotfiles-setup"
SETUP_LOG_FILE="$SETUP_FOLDER/dotfiles-setup.log"

if [ ! -f "$SETUP_LOG_FILE" ]; then
    sudo -u $USER mkdir -p $SETUP_FOLDER
    touch $SETUP_LOG_FILE
fi

#
# Install packages
#
echo "Running apt install..."
apt install -y \
    git \
    zsh \
    unzip \
    zip &>> $SETUP_LOG_FILE

#
# Install oh-my-zsh
#
OH_MY_ZSH="$USER_HOME/.oh-my-zsh"
if [ ! -d "$OH_MY_ZSH" ]; then
    echo "Installing oh-my-zsh..."
    sudo -u $USER /usr/bin/git clone https://github.com/ohmyzsh/ohmyzsh.git $OH_MY_ZSH &>> $SETUP_LOG_FILE
fi

#
# Install custom oh-my-zsh plugins
#
ZSH_NVM=$OH_MY_ZSH/custom/plugins/zsh-nvm
if [ ! -d "$ZSH_NVM" ]; then
    echo "Installing zsh-nvm plugin..."
    sudo -u $USER /usr/bin/git clone https://github.com/lukechilds/zsh-nvm $ZSH_NVM &>> $SETUP_LOG_FILE
fi

#
# Install SDKMAN
#
SDKMAN_DIR="$USER_HOME/.sdkman"
if [ ! -d "$SDKMAN_DIR" ]; then
    echo "Installing SDKMAN!..."
    sudo -u $USER bash -c "$(curl -fsSL https://get.sdkman.io?rcupdate=false)" &>> $SETUP_LOG_FILE
fi

#
# Clone dotfiles
#
DOTFILES="$USER_HOME/.dotfiles"
if [ ! -d "$DOTFILES" ]; then
    echo "Initializing dotfiles..."
    sudo -u $USER /usr/bin/git clone --bare https://github.com/dizk/dotfiles.git $DOTFILES &>> $SETUP_LOG_FILE
    sudo -u $USER /usr/bin/git --git-dir=$DOTFILES --work-tree=$USER_HOME checkout &>> $SETUP_LOG_FILE
else
    echo "Updating dotfiles..."
    sudo -u $USER /usr/bin/git --git-dir=$DOTFILES --work-tree=$USER_HOME pull &>> $SETUP_LOG_FILE
fi

#
# Change default shell for user
#
chsh -s $(which zsh) $USER &>> $SETUP_LOG_FILE

echo "OK! Close this teminal and open a new one ;)"
