#!/bin/sh

for line in $(cat $MODULE/Xresources); do
    ./write.py $line ~/.Xresources
done
