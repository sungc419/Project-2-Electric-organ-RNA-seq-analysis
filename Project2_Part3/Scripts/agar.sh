#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=agar
#SBATCH --time=12:00:00


/usr/bin/time -v agat_convert_sp_gff2gtf.pl --gff campylomormyrus.gff \
    -o campylomormyrus.gtf