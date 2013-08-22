#!/bin/sh
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc zshrc oh-my-zsh config"

########## Setup zsh and oh-my-zsh

# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already
    # present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git
        cp -f eturnilnetwork.zsh-theme oh-my-zsh/custom/
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
fi

########## Move files

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/dotfiles directory specified
# in $files
echo "Backing up any existing dotfiles in ~ to $olddir and replacing with dotfiles symlinks"
for file in $files; do
    mv -f ~/.$file ~/dotfiles_old/
    echo "Linking ~/.$file"
    ln -fs $dir/$file ~/.$file
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
