#!/bin/sh

./write.py "(load-file \"$MODULE/emacs.el\")" ~/.emacs
./write.py "alias emacs=$MODULE/emacsclient.sh" ~/.zshrc
./write.py "export EDITOR=$MODULE/emacsclient.sh" ~/.zshrc
./write.py "export VISUAL=\$EDITOR" ~/.zshrc

for line in $(cat $MODULE/Xresources); do
    ./write.py $line ~/.Xresources
done

if type "emacs" > /dev/null; then
    echo
    echo "Installing emacs packages"
    emacs -l $MODULE/emacspacks.el --batch
    echo
    echo "Byte compiling emacs config"
    emacs --batch --eval '(byte-compile-file "$MODULE/emacs.el")'
    if hash git 2>/dev/null; then
        git config --global core.editor 'emacsclient -a "nano"'
    fi
fi
