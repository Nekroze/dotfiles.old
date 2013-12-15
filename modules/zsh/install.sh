#!/bin/sh

write() {
    if ! grep -q $1 $2 ; then
        touch $2
        (echo $1; cat $2) >tmpfile
        mv tmpfile $2
    fi
}

write "source $DOTFILES/modules/shell/exports.sh" ~/.zshrc
write "source $DOTFILES/modules/shell/aliases.sh" ~/.zshrc
write "source $DOTFILES/modules/zsh/zsh.sh" ~/.zshrc
write "DEBIAN_PREVENT_KEYBOARD_CHANGES=yes" ~/.zshenv

# Clone oh-my-zsh as required.
if [[ ! -d ~/oh-my-zsh/ ]]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else # Update the current repo.
    CURR=`pwd`
    cd ~/.oh-my-zsh/
    git pull
    cd "$CURR"
fi

# Install eturnilnetwork zsh theme.
mkdir -p ~/.oh-my-zsh/custom/
cp -f $DOTFILES/modules/zsh/eturnilnetwork.zsh-theme ~/.oh-my-zsh/custom/

# Install zsh-syntax-hightlighting.
if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    mkdir -p ~/.oh-my-zsh/custom/plugins/
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-hightlighting
else # Update the current repo.
    CURR=`pwd`
    cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git pull
    cd "$CURR"
fi

# Install virtualenv-prompt
if [[ ! -d ~/.oh-my-zsh/custom/plugins/virtualenv-prompt ]]; then
    mkdir -p ~/.oh-my-zsh/custom/plugins/
    git clone git://github.com/tonyseek/oh-my-zsh-virtualenv-prompt.git ~/.oh-my-zsh/custom/plugins/virtualenv-prompt
else # Update the current repo.
    CURR=`pwd`
    cd ~/.oh-my-zsh/custom/plugins/virtualenv-prompt
    git pull
    cd "$CURR"
fi

# Install eturnilnetwork zsh theme.
mkdir -p ~/.oh-my-zsh/custom/
cp -f $DOTFILES/modules/zsh/eturnilnetwork.zsh-theme ~/.oh-my-zsh/custom/
