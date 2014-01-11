#!/bin/sh

echo "Installing package-query"
curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
tar zxvf package-query.tar.gz
cd package-query
makepkg -si
cd ..
rm -rf package-query

echo "Installing yaourt"
curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
tar zxvf yaourt.tar.gz
cd yaourt
makepkg -si
cd ..
rm -rf yaourt

yaourt -s aurvote
yaourt -s git wget emacs-nox rxvt-unicode zsh
yaourt -s python python-virtualenvwrapper python-pip python-tox python-sphinx python2 pypy
