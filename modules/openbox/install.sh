#!/bin/sh

mkdir -p ~/.config/openbox
for f in $MODULE/openbox/*; do
    if [ ! -f ~/.config/openbox/$(basename $f)-original ]; then
        if [ -f ~/.config/openbox/$(basename $f) ]; then
            cp ~/.config/openbox/$(basename $f) ~/.config/openbox/$(basename $f)-original
        fi
    fi
    cp $f ~/.config/openbox/$(basename $f)
done
