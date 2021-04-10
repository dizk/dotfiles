# Install

Run this on ubuntu

```
curl -s https://raw.githubusercontent.com/dizk/.dotfiles/master/.dotfiles-setup/setup.sh | sudo bash
```


# Usage

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