#!/bin/sh

if [ -z $SILENT ] ; then
    echo
    echo "What is your name?"
    read NAME
    echo "What is your email address?"
    read EMAIL
    git config --global user.name "$NAME"
    git config --global user.email "$EMAIL"
else
    echo "Skipping git name and email config"
fi
git config --global --add color.ui true
git config --global push.default tracking
git config --global core.whitespace trailing-space,space-before-tab
git config --global diff.renames copies
git config --global diff.mnemonicprefix true
git config --global branch.autosetupmerge true
git config --global rerere.enabled true
git config --global merge.stat true
