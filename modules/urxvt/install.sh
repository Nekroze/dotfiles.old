#!/bin/sh

write() {
    if ! grep -q $1 $2 ; then
        touch $2
        (echo $1; cat $2) >tmpfile
        mv tmpfile $2
    fi
}

for line in $(cat $DOTFILES/modules/Urxvt/Xresources); do
    write $line ~/.Xresources
done