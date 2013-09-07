#!/bin/sh
############################
# programs.sh
# This script installs some handy programs
############################

PROGRAMS="emacs24 terminator zsh aspell-en mc python python-pip python-setuptools python-tox python-sphinx python-pytest python-dev pyflakes pep8 pylint python-tox"
PYPACKAGES="cookiecutter flake8"
echo
echo "Installing Software Packages"

if hash apt-get >/dev/null; then
    echo "apt-get detected"
    PACKER="apt-get install"
elif hash packer >/dev/null; then
    echo "packer detected"
    PACKER="packer -S --no-edit"
elif hash pacman >/dev/null; then
    echo "pacman detected"
    PACKER="pacman -S"
elif [ "$QUITE" != "TRUE" ]; then    
    echo "What command do you use to install packages? Including options?"
    read PACKER
    if hash $PACKER >/dev/null; then
        exit 2;
    fi
fi

if hash sudo >/dev/null; then
    exec sudo $PACKER $PROGRAMS
else
    exec sudo $PACKER $PROGRAMS
fi

echo 
echo "Installing python packages"
if hash sudo >/dev/null; then
    echo "sudo detected"
    exec sudo pip install $PYPACKAGES
else
    exec pip install $PYPACKAGES
fi
