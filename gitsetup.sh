#!/bin/sh
############################
# gitsetup.sh
# This script installs some handy global git configs for the current user
# and can clone all of your repositories from github.
############################

echo "\nWhat is your name?"
read NAME
echo "What is your email address?"
read EMAIL
git config --global user.name "$NAME"
git config --global user.email $EMAIL
git config --global --add color.ui true
git config --global push.default tracking
git config --global core.whitespace trailing-space,space-before-tab
git config --global diff.renames copies
git config --global diff.mnemonicprefix true
git config --global branch.autosetupmerge true
git config --global rerere.enabled true
git config --global merge.stat true

#echo "Do you want to clone all your github repos with ssh?"
#select yn in "Yes" "No"; do
#    case $yn in
#        Yes ) ruby ~/dotfiles/gitback.rb; break;;
#        No ) break;;
#    esac
#done
