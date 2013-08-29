# Exports
## Rpython Compiler
export RPTRANSLATE=~/src/pypy/pypy/translator/goal/translate.py
export RPYTHON="PYTHONPATH=~/src/pypy:$PYTHONPATH pypy $RPTRANSLATE"
## Editor
export EDITOR=~/dotfiles/emacsclient.sh
export VISUAL=$EDITOR
## Terminal
if [ $TERM = "xterm" ]; then
    export TERM=xterm-256color
fi
