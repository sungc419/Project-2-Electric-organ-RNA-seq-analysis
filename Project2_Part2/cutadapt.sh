#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=cutadapt
#SBATCH --time=12:00:00

# /usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
# 	-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
# 	-o Cco_com101_EO_adult_1_1_cut.fastq.gz \
# 	-p Cco_com101_EO_adult_1_2_cut.fastq.gz \
# 	Cco_com101_EO_adult_1_1.fastq.gz \
# 	Cco_com101_EO_adult_1_2.fastq.gz

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
	-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
	-o CcoxCrh_comrhy110_EO_adult_1_1_cut.fastq.gz \
	-p CcoxCrh_comrhy110_EO_adult_1_2_cut.fastq.gz \
	CcoxCrh_comrhy110_EO_adult_1_1.fastq.gz \
	CcoxCrh_comrhy110_EO_adult_1_2.fastq.gz

