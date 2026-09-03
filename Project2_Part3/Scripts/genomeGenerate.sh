#!/bin/bash
#SBATCH --account=bgmp                    
#SBATCH --partition=bgmp                  
#SBATCH --cpus-per-task=8                 
#SBATCH --job-name=genomeGen 
#SBATCH --time=12:00:00                

/usr/bin/time -v pixi run STAR \
 --runThreadN 8 \
 --runMode genomeGenerate \
 --genomeDir campylomormyrus_STAR_2.7.11b/ \
 --genomeFastaFiles campylomormyrus.fasta \
 --sjdbGTFfile campylomormyrus.gtf
