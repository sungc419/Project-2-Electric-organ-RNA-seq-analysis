#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=trimm
#SBATCH --time=12:00:00

/usr/bin/time -v zcat Cco_com101_EO_adult_1_1_paired.fastq.gz | sed -n '2~4p' | awk '{print length($0)}' | sort -n | uniq -c | sort -n > Cco_com101_EO_adult_1_1_readlength.tsv

/usr/bin/time -v zcat Cco_com101_EO_adult_1_2_paired.fastq.gz | sed -n '2~4p' | awk '{print length($0)}' | sort -n | uniq -c | sort -n > Cco_com101_EO_adult_1_2_readlength.tsv

/usr/bin/time -v zcat CcoxCrh_comrhy110_EO_adult_1_1_paired.fastq.gz | sed -n '2~4p' | awk '{print length($0)}' | sort -n | uniq -c | sort -n > CcoxCrh_comrhy110_EO_adult_1_1.readlength.tsv

/usr/bin/time -v zcat CcoxCrh_comrhy110_EO_adult_1_2_paired.fastq.gz | sed -n '2~4p' | awk '{print length($0)}' | sort -n | uniq -c | sort -n > CcoxCrh_comrhy110_EO_adult_1_2.readlength.tsv