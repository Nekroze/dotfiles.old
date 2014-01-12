#!/bin/sh

./write.py "source $MODULES/shell/exports.sh" ~/.zshrc
./write.py "source $MODULES/shell/aliases.sh" ~/.zshrc
./write.py "source $MODULE/zsh.sh" ~/.zshrc
./write.py "DEBIAN_PREVENT_KEYBOARD_CHANGES=yes" ~/.zshenv

# Clone oh-my-zsh as required.
if [ ! -d ~/oh-my-zsh/ ] ; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else # Update the current repo.
    CURR=`pwd`
    cd ~/.oh-my-zsh/
    git pull
    cd "$CURR"
fi

# Install eturnilnetwork zsh theme.
mkdir -p ~/.oh-my-zsh/custom/
cp -f $MODULE/eturnilnetwork.zsh-theme ~/.oh-my-zsh/custom/

# Install zsh-syntax-hightlighting.
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] ; then
    mkdir -p ~/.oh-my-zsh/custom/plugins/
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-hightlighting
else # Update the current repo.
    CURR=`pwd`
    cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git pull
    cd "$CURR"
fi

# Install virtualenv-prompt
if [ ! -d ~/.oh-my-zsh/custom/plugins/virtualenv-prompt ] ; then
    mkdir -p ~/.oh-my-zsh/custom/plugins/
    git clone git://github.com/tonyseek/oh-my-zsh-virtualenv-prompt.git ~/.oh-my-zsh/custom/plugins/virtualenv-prompt
else # Update the current repo.
    CURR=`pwd`
    cd ~/.oh-my-zsh/custom/plugins/virtualenv-prompt
    git pull
    cd "$CURR"
fi
