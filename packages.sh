#!/bin/sh
############################
# programs.sh
# This script installs some handy programs
############################

PROGRAMS="emacs24 terminator zsh aspell-en mc python python-pip python-setuptools python-tox python-sphinx python-pytest"
PYPACKAGES="cookiecutter flake8 pylint"

echo "\nInstalling Software Packages"
echo "What command do you use to install packages? Including options?"
read PACKER
if [[ -z $PACKER ]]; then exit 2; fi

exec $PACKER $PROGRAMS

echo "\nInstalling Python Packages"
echo "Do you need to use sudo to install things?"
select yn in "Yes" "No" "Skip"; do
    case $yn in
        Yes ) exec sudo pip install $PYPACKAGES; break;;
        No ) exec pip install $PYPACKAGES; break;;
        Skip ) break;;
    esac
done
