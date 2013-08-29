plugins="marmalade makefile-runner org solarized-theme markdown-mode git-commit git-commit-mode flycheck flymake tox auto-complete auto-indent-mode d-mode gitignore-mode highlight idomenu ido-ubiquitous jinja2-mode lineno marmalade pep8 pyflakes pylint pytest python-mode python solarized-theme starter-kit starter-kit-bindings"

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
