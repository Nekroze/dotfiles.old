#!/bin/env python
# -*- mode: python; coding: utf-8 -*-
from __future__ import print_function
__doc__ = """Installation script for Nekroze's dotfiles package."""
from subprocess import call
from os import path, environ
from glob import glob


try:
    raw_input
except NameError:
    raw_input = input


environ["DOTFILES"] = os.path.dirname(os.path.realpath(__file__))


def ask_perform(description, commands):
    """
    Displays the description to the user and offers the choice of executing the
    given commands using the `perform` function. If no user input is given it
    will be considered a yes.
    """
    print(description)
    answer = raw_input("[Y/n]>")
    if not answer or (isinstance(answer, str) and answer.lower() in ("y", "yes")):
        perform(commands)


def perform(commands):
    """
    Executes the given commands each on the shell. Commands may be provided as
    a list of strings or a single string which will be split into a list of 
    strings for each line.
    """
    if isinstance(commands, str):
        commands = commands.split()

    for command in commands:
        check_call(command.split())


def read_description(filename):
    """
    Read a special description comment from the given filename. Only the first
    description block will be read.

    The description comment is all lines between two lines that contain five
    pound/crunch symbols (#). The first five bang/crunch line will provide the
    short description and the rest until the final five bang/crunch line will
    provide the long description.

    Each of these lines have their first character
    removed which should be another pound/crunch anyways.

    For example:
    ##### Description
    # where we describe stuff.
    # lots of stuff.
    #####

    The above, when read with this function, will yield the following data
    structure:
    ("Description", "where we describe stuff.\nlots of stuff.")
    """
    found = False
    description = []
    short = ""
    with open(filename, 'r') as f:
         for line in f:
             if line == "#"*5:
                 if not found:
                     short = line[5:].strip()
                     found = True
                 else:
                     break
             elif found and line:
                 description.append(line[1:].strip())
    else:
        print("<<<<<ERROR>>>>>")
        print("No description section found in {0}!".format(filename))
        exit()
    return (short, "\n".join(description))


def main(args):
    """Main entry point"""
    scripts = glob(path.join(environ["DOTFILES"], "*.sh"))
    for script in scripts:
        short, desc = read_description(script)
        print("c[] {1}".format(short))
        if args and short in args:
            perform(script)
        else:
            ask_perform(desc, script)
    return 0


if __name__ == "__main__":
    from sys import argv
    main(argv[1:])
