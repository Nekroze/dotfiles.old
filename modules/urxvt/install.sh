#!/bin/sh

for line in $(cat $DOTFILES/modules/urxvt/Xresources); do
    ./write.py $line ~/.Xresources
done
