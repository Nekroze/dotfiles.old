#!/bin/sh
############################
# programs.sh
# This script installs some handy programs
############################

PROGRAMS="emacs mc python python-pip python-setuptools"
PYPACKAGES="cookiecutter"

echo
echo "What command do you use to install packages? Including options?"
read PACKER
if [[ -z $PACKER ]]; then exit 2; fi

exec $PACKER $PROGRAMS

echo "Do you need to use sudo to install things?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) exec sudo pip install $PYPACKAGES; break;;
        No ) exec pip install $PYPACKAGES; break;;
    esac
done
