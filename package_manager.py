#!/bin/env python
# -*- mode: python; coding: utf-8 -*-
from __future__ import print_function
__doc__ = """Attempt at a universal package manager wrapper."""
from subprocess import call
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
            prefix = "sudo " if command_exists("sudo") else ""
            environ["PACKUPDATE"] = prefix + managers[manager]["update"]
            environ["PACKUPGRADE"] = prefix + managers[manager]["upgrade"]
            environ["PACKINSTALL"] = prefix + managers[manager]["install"]
            environ["PACKREMOVE"] = prefix + managers[manager]["remove"]
            environ["PACKCLEAN"] = prefix + managers[manager]["clean"]
            break
