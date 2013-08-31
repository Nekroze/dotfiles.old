#!/bin/sh
############################
# programs.sh
# This script installs some handy programs
############################

PROGRAMS="emacs24 terminator zsh aspell-en mc python python-pip python-setuptools python-tox python-sphinx python-pytest python-dev pyflakes pep8 pylint python-tox"
PYPACKAGES="cookiecutter flake8"
echo
echo "Installing Software Packages"
echo "What command do you use to install packages? Including options?"
read PACKER
if [[ -z $PACKER ]]; then exit 2; fi

exec $PACKER $PROGRAMS
echo 
echo "Installing python packages"
exec sudo pip install $PYPACKAGES
