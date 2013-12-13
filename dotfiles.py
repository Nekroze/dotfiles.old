#!/bin/env python
# -*- mode: python; coding: utf-8 -*-
from __future__ import print_function
__doc__ = """Installation script for Nekroze's dotfiles package."""
from subprocess import check_call
from os import path, environ
from glob import glob
import json


try:
    raw_input
except NameError:
    raw_input = input


environ["DOTFILES"] = path.dirname(path.realpath(__file__))


def ask_execute(description, script):
    """
    Displays the description to the user and offers the choice of executing the
    given script. If no user input is given it will be considered a yes.
    """
    print(description)
    answer = raw_input("\n[Y/n]>")
    if not answer or answer.lower() in ("y", "yes"):
        check_call(script, shell=True)


def main(args):
    """
    Main entry point.

    Collects module install scripts by looking for an "install.sh" file in any
    directory under "./modules/" assuming "./" is the dotfiles repo. As a glob
    pattern this search is represented as "./modules/*/install.sh"

    For each script that is collected its descriptions are loaded and its name
    is displayed.

    If no arguments are given to this script then the user will be asked about
    installing each module after being given its description.
    
    To run without user input enter the name for each module to be executed  as
    an argument to this script.
    
    Providing an invalid module name argument will simply display all available
    module names.
    """
    # Load all module definitions
    modules_dir = path.join(environ["DOTFILES"], "modules")
    pattern = path.join(modules_dir, "*", "module.json")
    modules = {}
    for module in glob(pattern):
        with open(module) as f:
            struct = json.load(f)
        struct["script"] = path.join(path.dirname(module), struct["script"])
        modules[struct["name"]] = struct

    # Execute each module
    for module in modules:
        module = modules[module]
        print("c[] {0}".format(module["name"]))
        if not args:
            ask_execute(module["name"], module["script"])
        else:
            if module["name"] in args:
                check_call(module["script"], shell=True)
    return 0


if __name__ == "__main__":
    from sys import argv
    main(argv[1:])
