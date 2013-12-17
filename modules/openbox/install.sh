#!/bin/sh

DOTFILES=~/dotfiles

mkdir -p ~/.config/openbox
for f in $DOTFILES/modules/openbox/openbox/*; do
    if [ -f ~/.config/openbox/$(basename $f) ]; then
        cp ~/.config/openbox/$(basename $f) ~/.config/openbox/$(basename $f)-original
    fi
    cp $f ~/.config/openbox/$(basename $f)
done
