#!/bin/sh

mkdir -p ~/.config/openbox
for f in $DOTFILES/modules/openbox/openbox/*; do
    if [ -f ~/.config/openbox/$(basename $f) ]; then
        cp ~/.config/openbox/$(basename $f) ~/.config/openbox/$(basename $f)-original
    fi
    ln -s $f ~/.config/openbox/$(basename $f)
done
