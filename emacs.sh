if type "emacs" > /dev/null; then
    echo
    echo "Installing emacs packages"
    emacs -l ~/dotfiles/emacspacks.el --batch
    echo
    echo "Byte compiling emacs config"
    emacs --batch --eval '(byte-compile-file "~/dotfiles/emacs.el")'
else
    echo
    echo "emacs not found!"
fi
