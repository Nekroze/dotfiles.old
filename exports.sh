# Exports
## Rpython Compiler
export RPTRANSLATE=~/src/pypy/pypy/translator/goal/translate.py
export PYPYSRC=~/src/pypy
if hash pypy 2>/dev/null; then
    export PYTHONBIN=pypy
elif hash python2 2>/dev/null; then
    export PYTHONBIN=python2
elif hash python3 2>/dev/null; then
    export PYTHONBIN=python3
else
    export PYTHONBIN=python
fi
## Editor
export EDITOR=~/dotfiles/emacsclient.sh
export VISUAL=$EDITOR
## Terminal
if [ $TERM = "xterm" ]; then
    export TERM=xterm-256color
fi
