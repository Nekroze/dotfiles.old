plugins="marmalade makefile-runner org solarized-theme markdown-mode git-commit-mode flycheck flymake"

if type "emacs" > /dev/null; then
    echo
    echo "Byte compiling emacs config"
    emacs --batch --eval '(byte-compile-file "~/dotfiles/emacs.el")'

    for plugin in $plugins; do
        emacs -l ~/.emacs --batch --eval "(package-install '$plugin)"
    done
else
    echo
    echo "emacs not found!"
fi
