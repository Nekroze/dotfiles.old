# Exports
## Local Bin
PATH=~/.local/bin:$PATH
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
