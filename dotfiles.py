#!/bin/env python
# -*- mode: python; coding: utf-8 -*-
from __future__ import print_function
__doc__ = """Installation script for Nekroze's dotfiles package."""
from subprocess import check_call
from os import path, environ
from glob import glob


try:
    raw_input
except NameError:
    raw_input = input


environ["DOTFILES"] = path.dirname(path.realpath(__file__))


def ask_perform(description, commands):
    """
    Displays the description to the user and offers the choice of executing the
    given commands using the `perform` function. If no user input is given it
    will be considered a yes.
    """
    print(description)
    answer = raw_input("\n[Y/n]>")
    if not answer or answer.lower() in ("y", "yes"):
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
    name as the following word and the rest until the next five bang/crunch
    line will provide the long description.

    Each of these lines have their first character removed which should be
    another pound/crunch anyways.

    For example:
    ##### Name
    # where we describe stuff.
    # lots of stuff.
    #####

    The above, when read with this function, will yield the following data
    structure:
    ("Name", "where we describe stuff.\nlots of stuff.")

    """
    found = False
    description = []
    name = ""
    with open(filename, 'r') as f:
        for line in f:
            if line[:5] == "#"*5:
                if not found:
                    name = line[5:].strip().split()
                    name = name[0] if name else ""
                    found = True
                else:
                    break
            elif found and line:
                description.append(line[1:].strip())
        else:
            print("<<<<<ERROR>>>>>")
            print("No/Invalid description section found in {0}!".format(filename))
            exit()
    return (name, "\n".join(description))


def main(args):
    """
    Main entry point.

    Collects module install scripts by looking for an "install.sh" file in any
    directory under "./modules/" assuming "./" is the dotfiles repo. As a glob
    pattern this search is represented as "./modules/*/install.sh"

    For each script that is collected its descriptions are loaded and its name
    is displayed.

    If no arguments are given to this script then the user will be questioned
    before running each script after being given its long description.
    
    To run without user input enter the name for each script to be executed as
    an argument to this script.
    
    Providing an invalid name argument will simply display all
    available script names.
    """
    scripts = glob(path.join(environ["DOTFILES"], "modules", "*", "install.sh"))
    for script in scripts:
        short, desc = read_description(script)
        print("c[] {0}".format(short))
        if not args:
            ask_perform(desc, script)
        else:
            if short in args:
                perform(script)
        print()
    return 0


if __name__ == "__main__":
    from sys import argv
    main(argv[1:])
