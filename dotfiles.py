#!/bin/env python
# -*- mode: python; coding: utf-8 -*-
from __future__ import print_function
__doc__ = """
Installation script for Nekroze's dotfiles package.
"""
from subprocess import call
from os import path, environ

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


def main(args):
    """Main entry point"""
    return 0


if __name__ == "__main__":
    from sys import argv
    main(argv[1:])
