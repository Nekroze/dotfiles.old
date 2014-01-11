#!/usr/bin/env python
# -*- mode: python; coding: utf-8 -*-
from __future__ import print_function
__doc__ = """Installation script for Nekroze's dotfiles package."""
from package_manager import detect_package_manager
from subprocess import check_call
from os import path, environ, chdir
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


def resolve_dependency_order(modules):
    """
    Builds a list of module names to be executed in order so as to avoid
    dependency conflicts.
    """
    order = []
    while modules:
        count = len(modules)
        if count == 1:
            order.append(list(modules.values())[0]["name"])
            break

        for name in modules:
            resolved = [True if dep in order else False 
                        for dep in modules[name]["dependencies"]]
            if resolved.count(True) == len(modules[name]["dependencies"]):
                order.append(name)

        for name in order:
            if name in modules:
                del modules[name]
        
        # No change in count likely means circular dependency
        if count == len(modules):
            print("<<<<<ERROR>>>>>")
            print("Cannot resolve dependencies")
            for module in modules.values():
                print(module)
                exit()
    return order


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
    """
    detect_package_manager()
    # Load all module definitions
    modules_dir = path.join(environ["DOTFILES"], "modules")
    pattern = path.join(modules_dir, "*", "module.json")
    modules = {}
    for module in glob(pattern):
        with open(module) as f:
            struct = json.load(f)
        struct["script"] = path.join(path.dirname(module), struct["script"])
        modules[struct["name"]] = struct

    # Ensure module template is not used
    if "Template" in modules:
        del modules["Template"]

    # Execute each module
    for name in modules:
        module = modules[name]
        print("c[] {0}".format(module["name"]))
        ask_execute(module["description"], module["script"])

    return 0


if __name__ == "__main__":
    from sys import argv
    if path.dirname(argv[0]):
        chdir(path.dirname(argv[0]))
    main(argv[1:])
