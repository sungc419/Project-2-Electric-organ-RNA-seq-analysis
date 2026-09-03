#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=trimm
#SBATCH --time=12:00:00

/usr/bin/time -v trimmomatic PE -threads 8 -Xmx16g \
    Cco_com101_EO_adult_1_1_cut.fastq.gz Cco_com101_EO_adult_1_2_cut.fastq.gz \
    Cco_com101_EO_adult_1_1_paired.fastq.gz Cco_com101_EO_adult_1_1_unpaired.fastq.gz \
    Cco_com101_EO_adult_1_2_paired.fastq.gz Cco_com101_EO_adult_1_2_unpaired.fastq.gz \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

/usr/bin/time -v trimmomatic PE -threads 8 -Xmx16g \
    CcoxCrh_comrhy110_EO_adult_1_1_cut.fastq.gz CcoxCrh_comrhy110_EO_adult_1_2_cut.fastq.gz \
    CcoxCrh_comrhy110_EO_adult_1_1_paired.fastq.gz CcoxCrh_comrhy110_EO_adult_1_1_unpaired.fastq.gz \
    CcoxCrh_comrhy110_EO_adult_1_2_paired.fastq.gz CcoxCrh_comrhy110_EO_adult_1_2_unpaired.fastq.gz \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35