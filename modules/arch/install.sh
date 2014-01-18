#!/bin/sh

echo "Installing package-query"
curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
tar zxvf package-query.tar.gz
cd package-query
makepkg -si --noconfirm
cd ..
rm -rf package-query

echo "Installing yaourt"
curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
tar zxvf yaourt.tar.gz
cd yaourt
makepkg -si --noconfirm
cd ..
rm -rf yaourt

./write.py "EDITFILES=0" ~/.yaourtrc
./write.py "NOCONFIRM=0" ~/.yaourtrc
./write.py "TERMINALTITLE=0" ~/.yaourtrc

yaourt -S aurvote
yaourt -S git wget emacs rxvt-unicode zsh
yaourt -S python python-virtualenvwrapper python-pip python-tox python-sphinx python2 pypy
