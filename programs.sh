#!/bin/sh
############################
# programs.sh
# This script installs some handy programs
############################

PROGRAMS="emacs mc python python-pip python-setuptools"

haveProg() {
    [ -x "$(which $1)" ]
}

if haveProg apt-get ; then $PACKER="apt-get install"
elif haveProg pacman ; then $PACKER="pacman -S"
else
    echo "What command do you use to install packages? Including options?"
    read PACKER
    if [ -z $PACKER ]; then exit 2; fi
fi

$PACKER $PROGRAMS
