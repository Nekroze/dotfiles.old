#!/usr/bin/env python2
from __future__ import print_function


def main(args):
    if len(args) != 2:
        print("Use no more then 2 arguments, a string and a file")

    with open(args[1], 'a+') as f:
        if args[0] not in f.read():
            f.write(args[0] + "\n")


if __name__ == "__main__":
    import sys
    main(sys.argv[1:])
