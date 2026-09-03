#!/bin/bash
#SBATCH --account=bgmp                    # REQUIRED: which account to use
#SBATCH --partition=bgmp                  # REQUIRED: which partition to use
#SBATCH --cpus-per-task=8                 # optional: number of cpus, default is 1
#SBATCH --job-name=align_refGen           # optional: job name
#SBATCH --time=12:00:00   

R1=Cco_com101_EO_adult_1_1_paired.fastq.gz
R2=Cco_com101_EO_adult_1_2_paired.fastq.gz
Gen_dir=campylomormyrus_STAR_2.7.11b/

/usr/bin/time -v pixi run STAR \
 --runThreadN 8 \
 --runMode alignReads \
 --outFilterMultimapNmax 3 \
 --outSAMunmapped Within KeepPairs \
 --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
 --readFilesCommand zcat \
 --readFilesIn $R1 $R2 \
 --genomeDir $Gen_dir \
 --outFileNamePrefix Cco_com101_EO_adult_1


R1=CcoxCrh_comrhy110_EO_adult_1_1_paired.fastq.gz
R2=CcoxCrh_comrhy110_EO_adult_1_2_paired.fastq.gz
Gen_dir=campylomormyrus_STAR_2.7.11b/

/usr/bin/time -v pixi run STAR \
 --runThreadN 8 \
 --runMode alignReads \
 --outFilterMultimapNmax 3 \
 --outSAMunmapped Within KeepPairs \
 --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
 --readFilesCommand zcat \
 --readFilesIn $R1 $R2 \
 --genomeDir $Gen_dir \
 --outFileNamePrefix CcoxCrh_comrhy110_EO_adult_1