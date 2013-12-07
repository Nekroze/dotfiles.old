if type "emacs" > /dev/null; then
    echo
    echo "Installing emacs packages"
    emacs -l ~/dotfiles/emacspacks.el --batch
    mkdir -p ~/.emacs.d/
    cd ~/.emacs.d
    git clone git://github.com/milkypostman/powerline.git
    echo
    echo "Byte compiling emacs config"
    emacs --batch --eval '(byte-compile-file "~/dotfiles/emacs.el")'
else
    echo
    echo "emacs not found!"
fi
