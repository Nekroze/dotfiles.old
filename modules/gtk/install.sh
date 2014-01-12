#!/bin/sh

# Install solarized-dark-gtk
if [ ! -d ~/.themes/solarized-dark-gtk ] ; then
    mkdir -p ~/.themes
    git clone https://github.com/jankotek/solarized-dark-gtk.git ~/.themes/solarized-dark-gtk
else # Update the current repo.
    CURR=`pwd`
    cd ~/.themes/solarized-dark-gtk
    git pull
    cd "$CURR"
fi
