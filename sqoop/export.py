#!/usr/bin/env python

import argparse
import subprocess
import sys

def main():
    parser = argparse.ArgumentParser(description="Exports all partitions of the Business table")
    parser.add_argument("-f", "--file", help="Path of stateCity.txt", required=True)

    args = parser.parse_args()

    with open(args.file) as f:
        for line in f:
            state, city = line.strip().split("\t")
            print("{0}, {1}".format(state, city))
            if (subprocess.call(["./exportSqoop.sh", state, city]) != 0):
                sys.exit("fail on input: {0} {1}".format(state, city))


if __name__ == "__main__":
    main()
