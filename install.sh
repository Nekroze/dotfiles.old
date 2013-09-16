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

# Clone oh-my-zsh repository from GitHub only if it isn't already present
if [[ ! -d $dir/oh-my-zsh/ ]]; then
    echo "Installing oh-my-zsh with custom theme"
    git clone https://github.com/robbyrussell/oh-my-zsh.git
    cp -f eturnilnetwork.zsh-theme oh-my-zsh/custom/
    mv -f ~/.oh-my-zsh $olddir
    mv oh-my-zsh ~/.oh-my-zsh
fi

########## Copy files

echo "Installing terminator config"
mkdir -p ~/.config $olddir/.config
mv -f ~/.config/terminator $olddir/.config/terminator
cp -r $dir/config/terminator ~/.config/

echo "Installing Xresourcees solarized settings"
mv -f ~/.Xresources $olddir/.Xresources
cat $dir/Xresources >> ~/.Xresources

echo "Installing bash config"
mv -f ~/.bashrc $olddir
echo "source ~/dotfiles/bash.sh
source ~/dotfiles/shellenv.sh" > ~/.bashrc

echo "Installing zsh config"
mv -f ~/.zshrc $olddir
echo "source ~/dotfiles/zsh.sh
source ~/dotfiles/shellenv.sh" > ~/.zshrc
# Fix for history completion in ubuntu/debian
echo "DEBIAN_PREVENT_KEYBOARD_CHANGES=yes" >> ~/.zshenv

echo "Installing emacs config"
mv -f ~/.emacs $olddir
echo "(load-file \"~/dotfiles/emacs.el\")" > ~/.emacs

########## Optional extras
if [ "$QUITE" = "TRUE" ]; then
    QUITE=$QUITE bash $dir/gitsetup.sh
    QUITE=$QUITE bash $dir/packages.sh
    QUITE=$QUITE bash $dir/emacs.sh
else
    echo
    echo "Do you wish to apply some useful global git configs?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) bash $dir/gitsetup.sh; break;;
            No ) break;;
        esac
    done

    echo
    echo "Do you wish to install some useful packages?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) bash $dir/packages.sh; break;;
            No ) break;;
        esac
    done

    echo
    echo "Do you wish to install some useful emacs plugins?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) bash $dir/emacs.sh; break;;
            No ) break;;
        esac
    done
fi

########## Exit

echo
echo "Installation completed"
echo "Solong and thanks for all the fish!"
