#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --job-name=zip08_1
#SBATCH --time=12:00:00

/usr/bin/time -v gzip /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis/SRR25630408_1.fastq
