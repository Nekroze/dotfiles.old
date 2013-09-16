#!/bin/sh
############################
# programs.sh
# This script installs some handy programs
############################

PROGRAMS="emacs24 zsh aspell-en mc python python-pip python-setuptools python-tox python-sphinx python-pytest python-dev pyflakes pep8 pylint python-tox python-cython"
PYPACKAGES="cookiecutter"

if hash apt-get >/dev/null; then
    echo "apt-get detected"
    PACKER="apt-get install -y"
    PROGRAMS="emacs24 zsh aspell-en mc python python-pip python-setuptools python-tox python-sphinx python-pytest python-dev pyflakes pep8 pylint python-tox python-cython"
elif hash packer >/dev/null; then
    echo "packer detected"
    PACKER="packer -S --noedit --noconfirm"
    PROGRAMS="emacs zsh aspell-en mc python python-pip python-setuptools python-tox python-sphinx python-pytest flake8 python-pylint python-tox python-cython twisted"
elif hash pacman >/dev/null; then
    echo "pacman detected"
    PACKER="pacman -S"
    PROGRAMS="emacs zsh aspell-en mc python python-pip python-setuptools python-sphinx pep8"
elif [ "$QUITE" != "TRUE" ]; then    
    echo "What command do you use to install packages, ie your package manager command with install options?"
    read PACKER
    if hash $PACKER >/dev/null; then
        echo "Package command not found"
        exit 2;
    fi
else
    echo
    echo "[!]Skipping package installation"
    PACKER="NONE"
fi

if [ "$PACKER" != "NONE" ]; then
    echo
    echo "Installing Software Packages"
    if hash sudo >/dev/null; then
        sudo $PACKER $PROGRAMS
    else
        sudo $PACKER $PROGRAMS
    fi
fi

if hash pip >/dev/null; then
    echo 
    echo "Installing python packages"
    if hash sudo >/dev/null; then
        echo "sudo detected"
        sudo pip install $PYPACKAGES
    else
        pip install $PYPACKAGES
    fi
else
    echo
    echo "[!]Skipping python package installation"
fi
