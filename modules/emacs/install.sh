#!/bin/sh

write() {
    if ! grep -q $1 $2 ; then
        touch $2
        (echo $1; cat $2) >tmpfile
        mv tmpfile $2
    fi
}

write "(load-file \"$DOTFILES/modules/emacs/emacs.el\")" ~/.emacs
write "alias emacs=$DOTFILES/modules/emacs/emacsclient.sh" ~/.zshrc
write "export EDITOR=$DOTFILES/modules/emacs/emacsclient.sh" ~/.zshrc
write "export VISUAL=\$EDITOR" ~/.zshrc

if type "emacs" > /dev/null; then
    echo
    echo "Installing emacs packages"
    emacs -l $DOTFILES/modules/emacs/emacspacks.el --batch
    echo
    echo "Byte compiling emacs config"
    emacs --batch --eval '(byte-compile-file "$DOTFILES/modules/emacs/emacs.el")'
    git config --global core.editor 'emacsclient -a "nano"'
else
    echo
    echo "emacs not found!"
fi
