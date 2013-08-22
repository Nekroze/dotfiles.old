#!/bin/sh
############################
# gitconfigs.sh
# This script installs some handy global git configs for the current user
############################

git config --global --add color.ui true
git config --global push.default tracking
git config --global core.whitespace trailing-space,space-before-tab
git config --global diff.renames copies
git config --global diff.mnemonicprefix true
git config --global branch.autosetupmerge true
git config --global rerere.enabled true
git config --global merge.stat true
