# Install

Run this:
```
curl -s https://raw.githubusercontent.com/dizk/dotfiles/main/.dotfiles-setup/setup.sh | sudo bash
```

# What will be installed?
* git
* zsh
* oh-my-zsh (https://github.com/ohmyzsh/ohmyzsh)
* zsh-nvm (https://github.com/lukechilds/zsh-nvm)
* sdkman (https://sdkman.io/)

# Changing the dotfiles in the repo

To add new dotfiles just use the `dotfiles` alias 

```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```

Check out the alias definition in .zshrc