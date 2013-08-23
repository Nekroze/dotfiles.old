#!/bin/sh
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc zshrc config/terminator/config"

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
    # Clone my oh-my-zsh repository from GitHub only if it isn't already
    # present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git
        cp -f eturnilnetwork.zsh-theme oh-my-zsh/custom/
        mv -f ~/.oh-my-zsh ~/dotfiles_old
        mv oh-my-zsh ~/.oh-my-zsh
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
fi

########## Copy files

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/dotfiles directory specified
# in $files
mkdir -p ~/.config/terminator
mkdir -p ~/dotfiles_old/.config/terminator
echo "Backing up any existing dotfiles $olddir and replacing symlinks"
for file in $files; do
    mv -f ~/.$file ~/dotfiles_old/
    echo "Linking ~/.$file"
    cp $dir/$file ~/.$file
done

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
