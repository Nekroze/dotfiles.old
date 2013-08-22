#!/bin/sh
############################
# programs.sh
# This script installs some handy programs
############################

PROGRAMS="emacs mc python python-pip python-setuptools"

echo "What command do you use to install packages? Including options?"
read PACKER
if [ -z $PACKER ]; then exit 2; fi

$PACKER $PROGRAMS
