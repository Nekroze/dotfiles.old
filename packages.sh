#!/bin/sh
############################
# programs.sh
# This script installs some handy programs
############################

PROGRAMS="emacs24 terminator zsh aspell-en mc python python-pip python-setuptools python-tox python-sphinx python-pytest python-dev pyflakes pep8 pylint python-tox"
PYPACKAGES="cookiecutter flake8"
echo
echo "Installing Software Packages"

if hash apt-get 2>/dev/null; then
    PACKER=apt-get install
elif hash packer 2>/dev/null; then
    PACKER=packer -S --no-edit
elif hash pacman 2>/dev/null; then
    PACKER=pacman -S
else
    echo "What command do you use to install packages? Including options?"
    read PACKER
    if hash $PACKER 2>/dev/null; then
        exit 2;
    fi
fi

if hash sudo 2>/dev/null; then
    exec sudo $PACKER $PROGRAMS
else
    exec sudo $PACKER $PROGRAMS
fi

echo 
echo "Installing python packages"
if hash sudo 2>/dev/null; then
    exec sudo pip install $PYPACKAGES
else
    exec pip install $PYPACKAGES
fi
