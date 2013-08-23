#!/bin/sh
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

########## Manage directories

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory ..."
cd $dir

########## Setup zsh and oh-my-zsh

# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        echo "Installing oh-my-zsh with custom theme"
        git clone https://github.com/robbyrussell/oh-my-zsh.git
        cp -f eturnilnetwork.zsh-theme oh-my-zsh/custom/
        mv -f ~/.oh-my-zsh ~/dotfiles_old
        mv oh-my-zsh ~/.oh-my-zsh
    fi
fi

########## Copy files

echo "Installing terminator config"
mkdir -p ~/.config ~/dotfiles_old/.config
mv -f ~/.config/terminator ~/dotfiles_old/.config/terminator
cp -r ~/dotfiles/config/terminator ~/.config/

echo "Installing bash config"
mv -f ~/.bashrc ~/dotfiles_old/
echo "source ~/dotfiles/bash.sh
source ~/dotfiles/shellenv.sh" > ~/.bashrc

echo "Installing zsh config"
mv -f ~/.zshrc ~/dotfiles_old/
echo "source ~/dotfiles/zsh.sh
source ~/dotfiles/shellenv.sh" > ~/.zshrc

echo "Installing emacs config"
mv -f ~/.emacs ~/dotfiles_old/
echo "(load-file \"~/dotfiles/emacs.el\")" > ~/.emacs

########## Optional extras

echo
echo "Do you wish to apply some useful global git configs?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sh ~/dotfiles/gitconfigs.sh; break;;
        No ) break;;
    esac
done

echo
echo "Do you wish to install some useful programs?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sh ~/dotfiles/programs.sh; break;;
        No ) break;;
    esac
done

echo
echo "Do you wish to install some useful emacs plugins?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sh ~/dotfiles/emacs.sh; break;;
        No ) break;;
    esac
done

########## Exit

echo
echo "Installation completed"
echo "Solong and thanks for all the fish!"
