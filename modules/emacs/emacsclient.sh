#!/bin/sh
xprop -name emacs >/dev/null 2>/dev/null
if [ "$?" = "1" ]; then
        echo "Opening New Frame"
        emacsclient -a "" -c -n -F "((fullscreen . maximized))" "$@"
else
        echo "Using Existing Frame"
        emacsclient -n "$@"
fi
