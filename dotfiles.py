#!/usr/bin/env python
# -*- mode: python; coding: utf-8 -*-
from __future__ import print_function
__doc__ = """Installation script for Nekroze's dotfiles package."""
from package_manager import detect_package_manager
from subprocess import check_call, call
from os import path, environ, chdir
import os
from glob import glob
import json


try:
    raw_input
except NameError:
    raw_input = input


environ["DOTFILES"] = path.dirname(path.realpath(__file__))
environ["MODULES"] = path.join(environ["DOTFILES"], "modules")
MISSING_COMMANDS = []


def ask_execute(module):
    """
    Displays the description to the user and offers the choice of executing the
    given script. If no user input is given it will be considered a yes.
    """
    print(module["description"])
    answer = raw_input("\n[Y/n]>")
    if not answer or answer.lower() in ("y", "yes"):
        just_execute(module)


def just_execute(module):
    """
    Check that the module has all the commands it needs then execute the given
    script and provide the MODULE env var.
    """
    missing = [com for com in MISSING_COMMANDS if com in module["commands"]]
    if missing:
        print("!! {0} module requires the following commands: {1}".format(
              module["name"], ' '.join(missing)))
        return False
    else:
	print("c[~] Executing " + module["name"])
        environ["MODULE"] = path.dirname(module["script"])
        check_call(module["script"], shell=True)
        return True


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

    This script can take a whitelist of module names to be executed or the
    special arguemnt ``silent`` which will automatically execute any modules
    that can be silent and not ask questions.
    """
    detect_package_manager()
    # Load all module definitions
    pattern = path.join(environ["MODULES"], "*", "module.json")
    modules = {}
    for module in glob(pattern):
        with open(module) as f:
            struct = json.load(f)
        struct["script"] = path.join(path.dirname(module), struct["script"])
        modules[struct["name"]] = struct
        # Check for commands
        for command in struct["commands"]:
            if call(["which", command]):
                print("WARNING: missing command " + command + " can cause problems")
                MISSING_COMMANDS.append(command)

    # Ensure module template is not used
    if "Template" in modules:
        del modules["Template"]

    if args:
        # Allow special execution of silent modules only
        if [1 for module in args if module.lower() == "silent"]:
            for name in modules:
                if modules[name]["silent"]:
                    environ["SILENT"] = "TRUE"
                    just_execute(modules[name])
            return 0

        # Ensure all args are valid module names
        bad_args = [module for module in args if module not in modules]
        if bad_args:
            print("ERROR - BAD MODULES:", ' '.join(bad_args))
            print("AVAILABLE MODULES:", ' '.join(modules.keys()))
            return 2

        # Execute selected modules
        for name in modules:
            if name in args:
                just_execute(modules[name])
                return 0
    else:
        # Execute each module
        for name in modules:
            module = modules[name]
            print("c[] {0}".format(module["name"]))
            ask_execute(module)

    return 0


if __name__ == "__main__":
    from sys import argv, exit
    if path.dirname(argv[0]):
        chdir(path.dirname(argv[0]))
    exit(main(argv[1:]))
