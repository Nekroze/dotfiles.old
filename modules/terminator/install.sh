#!/bin/sh

mkdir -p ~/.config/terminator
if [ -f ~/.config/terminator/config ]; then
    if [ ! -f ~/.config/terminator/config_original ]; then
        cp ~/.config/terminator/config ~/.config/terminator/config_original
    fi
fi
cp $MODULE/config ~/.config/terminator/config
