#!/bin/env python2
# -*- mode: python; coding: utf-8 -*-
from __future__ import print_function
__doc__ = """Attempt at a universal package manager wrapper."""
from subprocess import call, check_output
from os import environ
import json


def command_exists(program):
    """Returns True if the given command is available."""
    return False if call(["which", program]) else True


def detect_package_manager():
    """Returns a dictionary of commands for package management."""
    with open("package_managers.json") as f:
        managers = json.load(f)

    for manager in managers:
        if command_exists(manager):
            environ["PACKUPDATE"] = managers[manager]["update"]
            environ["PACKUPGRADE"] = managers[manager]["upgrade"]
            environ["PACKSEARCH"] = managers[manager]["search"]
            environ["PACKINSTALL"] = managers[manager]["install"]
            environ["PACKREMOVE"] = managers[manager]["remove"]
            environ["PACKCLEAN"] = managers[manager]["clean"]
            return managers[manager]


def attempt_install(packages, manager):
    for package in packages:
        output = check_output("{0} {1}".format(manager["search"], package).split())
        pattern = manager["pattern"].format(package)
        for line in output.split("\n"):
            if len(line) >= len(pattern) and line[:len(pattern)] == pattern:
                print("Installing package: " + package)
                call(manager["install"].split() + [package])


def main(args):
    manager = detect_package_manager()
    call(manager["update"].split())
    call(manager["upgrade"].split())


if __name__ == "__main__":
    from sys import argv
    main(argv[1:])
