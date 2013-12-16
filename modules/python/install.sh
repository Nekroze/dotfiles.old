#!/bin/sh

write() {
    if ! grep -q $1 $2 ; then
        touch $2
        (echo $1; cat $2) >tmpfile
        mv tmpfile $2
    fi
}

if type "pip" > /dev/null; then
    echo
    echo "Installing python packages"
    sudo pip install --upgrade -r $DOTFILES/modules/python/packages.txt
    write "export WORKON_HOME=~/envs" ~/.zshrc
    write "source /usr/local/bin/virtualenvwrapper.sh" ~/.zshrc
else
    echo
    echo "pip not found!"
fi
