plugins="marmalade makefile-runner org solarized-theme markdown-mode"

if type "emacs" > /dev/null; then
    echo
    echo "Byte compiling emacs config"
    emacs --batch --eval '(byte-compile-file "~/dotfiles/emacs.el")'

    for plugin in $plugins; do
        emacs --batch --eval '(package-install "${plugin}")'
    done
else
    echo
    echo "emacs not found!"
fi
