#!/bin/sh

if type "pip" > /dev/null; then
    echo
    echo "Installing python packages"
    sudo pip install --upgrade -r $MODULE/packages.txt
    ./write.py "export WORKON_HOME=~/envs" ~/.zshrc
    ./write.py "source /usr/local/bin/virtualenvwrapper.sh" ~/.zshrc
else
    echo
    echo "pip not found!"
fi
