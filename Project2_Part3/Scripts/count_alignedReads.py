#!/usr/bin/env python

import argparse 

def get_args():
    parser = argparse.ArgumentParser(description = "A program to take in sam file and print out number of mapped/unmapped reads.")
    parser.add_argument("-f", "--sam_file", help="aligned sam input file", required = True) 
    return parser.parse_args()
args = get_args()
file = args.sam_file

reads_mapped = 0
reads_unmapped = 0

with open (file, "r") as fh:
    for line in fh:
        if not line.startswith("@"):
            line = line.strip("\n").split("\t")
            if((int(line[1]) & 4) != 4):
                if((int(line[1]) & 256) != 256):
                    reads_mapped += 1
            else:
                if((int(line[1]) & 256) != 256):
                    reads_unmapped += 1
print(f'The number of reads mapped: {reads_mapped}')
print(f'The number of reads unmapped: {reads_unmapped}')
