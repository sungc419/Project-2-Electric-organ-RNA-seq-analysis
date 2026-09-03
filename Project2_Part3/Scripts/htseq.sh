#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=htseq3
#SBATCH --time=12:00:00

/usr/bin/time -v htseq-count -i Parent \
    --stranded=yes \
    Cco_com101_EO_adult_1Aligned.out.sam campylomormyrus.gff > Cco_com101_EO_adult_1_htseqcounts_forstranded.txt


/usr/bin/time -v htseq-count -i Parent \
    --stranded=yes \
    CcoxCrh_comrhy110_EO_adult_1Aligned.out.sam campylomormyrus.gff > CcoxCrh_comrhy110_EO_adult_1_htseqcounts_forstranded.txt


/usr/bin/time -v htseq-count -i Parent \
    --stranded=reverse \
    Cco_com101_EO_adult_1Aligned.out.sam campylomormyrus.gff > Cco_com101_EO_adult_1_htseqcounts_revstranded.txt


/usr/bin/time -v htseq-count -i Parent \
    --stranded=reverse \
    CcoxCrh_comrhy110_EO_adult_1Aligned.out.sam campylomormyrus.gff > CcoxCrh_comrhy110_EO_adult_1_htseqcounts_revstranded.txt