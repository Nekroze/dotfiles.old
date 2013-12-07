#!/bin/sh

xprop -name emacs >/dev/null 2>/dev/null
if [ "$?" = "1" ]; then
	echo "Opening New Frame"
	emacsclient --alternate-editor="" -c -n "$@"
else
	echo "Using Existing Frame"
	emacsclient -n "$@"
fi
