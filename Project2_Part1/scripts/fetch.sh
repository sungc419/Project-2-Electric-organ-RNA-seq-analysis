#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=fetch
#SBATCH --time=12:00:00

/usr/bin/time -v pixi run prefetch SRR25630408 --max-size u 
/usr/bin/time -v pixi run prefetch SRR25630384 --max-size u 
/usr/bin/time -v pixi run fasterq-dump SRR25630408 --threads 8 
/usr/bin/time -v pixi run fasterq-dump SRR25630384 --threads 8 