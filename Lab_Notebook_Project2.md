# Lab Notebook: Bi623-Project2
8/27/2026 - Downloaded the two SRR files that was assigned to me 

Project2 Folder Path: /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis

Version:
```
SRA tools 3.4.1
fastqc  0.12.1
cutadapt version 5.2
trimmomatic version 0.41
STAR 2.7.11b
Samtools 1.23.1
Numpy 2.5.2
Matplotlib 3.11.1
HTseq 2.1.2
agat 1.7.0
```
## Bi623-Project2-Part1
### Added SRA Toolkit, Fastqc, Cutadapt, and Trimmomatic to pixi environment

`pixi add sra-tools cutadapt trimmomatic fastqc`

### Using Pixi SRA Toolkit, built and ran script to fetch SRR files using prefetch and fasterq dump:

`sbatch fetch.sh `

slurm out:
``` 
Command being timed: "pixi run prefetch SRR25630408 --max-size u"
	User time (seconds): 30.42
	System time (seconds): 3.16
	Percent of CPU this job got: 16%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 3:22.65

Command being timed: "pixi run prefetch SRR25630384 --max-size u"
	User time (seconds): 5.00
	System time (seconds): 0.58
	Percent of CPU this job got: 16%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:33.89

Command being timed: "pixi run fasterq-dump SRR25630408 --threads 8"
	User time (seconds): 143.69
	System time (seconds): 12.73
	Percent of CPU this job got: 139%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:52.42

Command being timed: "pixi run fasterq-dump SRR25630384 --threads 8"
	User time (seconds): 23.27
	System time (seconds): 2.59
	Percent of CPU this job got: 145%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:17.75
```

### Built scripts to zip downloaded SRR files:

Script for zipping SRR25630384_1:
`sbatch zip_SRR25630384_1.sh`

slurm out:
```
Command being timed: "gzip /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis/SRR25630384_1.fastq"
	User time (seconds): 259.76
	System time (seconds): 0.89
	Percent of CPU this job got: 92%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 4:41.86
```

Script for zipping SRR25630384_2:
`sbatch zip_SRR25630384_2.sh`

slurm out:
```
Command being timed: "gzip /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis/SRR25630384_2.fastq"
	User time (seconds): 274.90
	System time (seconds): 0.90
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 4:37.10
```
Confirmed that I have the same number of reads for both files:

`zcat SRR25630384_1.fastq.gz | wc -l`

`zcat SRR25630384_2.fastq.gz | wc -l`

Both commands resulted in 35480188 reads

Script for zipping SRR25630408_1: `sbatch zip_SRR25630408_1.sh`

slurm out:
```
Command being timed: "gzip /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis/SRR25630408_1.fastq"
	User time (seconds): 1606.85
	System time (seconds): 5.10
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 26:58.22
```


Script for zipping SRR25630408_2:
`sbatch zip_SRR25630408_2.sh`

slurm out:
```
Command being timed: "gzip /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis/SRR25630408_2.fastq"
	User time (seconds): 1682.96
	System time (seconds): 5.35
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 28:13.77
```
### Ran FastQC on downloaded SRR files

Used this command:
`pixi run fastqc SRR25* –o /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis`

This generated these files:
```
SRR25630384_1_fastqc.html
SRR25630384_2_fastqc.html
SRR25630408_1_fastqc.html
SRR25630408_2_fastqc.html
```

### Renamed SRR files
Naming convention: Species_sample_tissue\_[ageORsize]\_sample#\_readnumber.fastq.gz (followed the csv in the repository).

Path: `/projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis/RNAseq_meta_campys.csv`

Old File Names:
```
SRR25630384_1.fastq.gz
SRR25630384_2.fastq.gz
```

Renamed to:
```
CcoxCrh_comrhy110_EO_adult_1_1.fastq.gz
CcoxCrh_comrhy110_EO_adult_1_2.fastq.gz
```

Old File Names:
```
SRR25630384_1.fastq.gz
SRR25630384_2.fastq.gz
```

Renamed to:
```
Cco_com101_EO_adult_1_1.fastq.gz	
Cco_com101_EO_adult_1_2.fastq.gz
```

## Bi623-Project2-Part2

Per FastQC reports, sequences have Illumina Universal Adapters. 

```
Adapter for R1: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA
Adapter for R2: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
```

Found them in the sequence using the following commands:

`zcat Cco_com101_EO_adult_1_1.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"`

`zcat Cco_com101_EO_adult_1_2.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`

`zcat CcoxCrh_comrhy110_EO_adult_1_1.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"`

`zcat CcoxCrh_comrhy110_EO_adult_1_2.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`

Wrote script to cut out adapters:

`cutadapt.sh`

Format from the documentation used for the script:

`cutadapt -a ADAPTER_FWD -A ADAPTER_REV -o out.1.fastq -p out.2.fastq reads.1.fastq reads.2.fastq`

slurm out:

```
This is cutadapt 5.2 with Python 3.12.14
Command line parameters: -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o Cco_com101_EO_adult_1_1_cut.fastq.gz -p Cco_com101_EO_adult_1_2_cut.fastq.gz Cco_com101_EO_adult_1_1.fastq.gz Cco_com101_EO_adult_1_2.fastq.gz
Processing paired-end reads on 1 core ...

=== Summary ===

Total read pairs processed:         54,900,823
  Read 1 with adapter:               9,563,128 (17.4%)
  Read 2 with adapter:               9,347,646 (17.0%)
Pairs written (passing filters):    54,900,823 (100.0%)

Total basepairs processed: 16,470,246,900 bp
  Read 1: 8,235,123,450 bp
  Read 2: 8,235,123,450 bp
Total written (filtered):  15,900,635,624 bp (96.5%)
  Read 1: 7,942,301,314 bp
  Read 2: 7,958,334,310 bp

Command being timed: "cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o Cco_com101_EO_adult_1_1_cut.fastq.gz -p Cco_com101_EO_adult_1_2_cut.fastq.gz Cco_com101_EO_adult_1_1.fastq.gz Cco_com101_EO_adult_1_2.fastq.gz"
	User time (seconds): 546.81
	System time (seconds): 1.94
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 9:12.43
```

slurm out:

```
This is cutadapt 5.2 with Python 3.12.14
Command line parameters: -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o CcoxCrh_comrhy110_EO_adult_1_1_cut.fastq.gz -p CcoxCrh_comrhy110_EO_adult_1_2_cut.fastq.gz CcoxCrh_comrhy110_EO_adult_1_1.fastq.gz CcoxCrh_comrhy110_EO_adult_1_2.fastq.gz
Processing paired-end reads on 1 core ...

=== Summary ===

Total read pairs processed:          8,870,047
  Read 1 with adapter:               1,934,140 (21.8%)
  Read 2 with adapter:               1,915,215 (21.6%)
Pairs written (passing filters):     8,870,047 (100.0%)

Total basepairs processed: 2,661,014,100 bp
  Read 1: 1,330,507,050 bp
  Read 2: 1,330,507,050 bp
Total written (filtered):  2,562,147,554 bp (96.3%)
  Read 1: 1,279,681,073 bp
  Read 2: 1,282,466,481 bp
  
  Command being timed: "cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o CcoxCrh_comrhy110_EO_adult_1_1_cut.fastq.gz -p CcoxCrh_comrhy110_EO_adult_1_2_cut.fastq.gz CcoxCrh_comrhy110_EO_adult_1_1.fastq.gz CcoxCrh_comrhy110_EO_adult_1_2.fastq.gz"
	User time (seconds): 64.55
	System time (seconds): 0.21
	Percent of CPU this job got: 96%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:07.25
```

Did another check to see if adapters were cut out.

For Cco_com101_EO_adult_1:

`zcat Cco_com101_EO_adult_1_1_cut.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"`

`zcat Cco_com101_EO_adult_1_2_cut.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`


For CcoxCrh_comrhy110_EO_adult_1:

`zcat CcoxCrh_comrhy110_EO_adult_1_2_cut.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`

`zcat CcoxCrh_comrhy110_EO_adult_1_2_cut.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`

Did not find any results with the search, which is expected since adapters are now gone.


Wrote script to trim sequences: `trimmomatic.sh`

Format from the documentation used for the script:
```
trimmomatic PE -threads 8 \
    input_forward.fq.gz input_reverse.fq.gz \
    output_forward_paired.fq.gz output_forward_unpaired.fq.gz \
    output_reverse_paired.fq.gz output_reverse_unpaired.fq.gz \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
```


slurm out:

```
Command being timed: "trimmomatic PE -threads 8 Cco_com101_EO_adult_1_1_cut.fastq.gz Cco_com101_EO_adult_1_2_cut.fastq.gz Cco_com101_EO_adult_1_1_paired.fastq.gz Cco_com101_EO_adult_1_1_unpaired.fastq.gz Cco_com101_EO_adult_1_2_paired.fastq.gz Cco_com101_EO_adult_1_2_unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35"
		User time (seconds): 4008.84
		System time (seconds): 77.26
		Percent of CPU this job got: 600%
		Elapsed (wall clock) time (h:mm:ss or m:ss): 11:20.03

Command being timed: "trimmomatic PE -threads 8 -Xmx16g CcoxCrh_comrhy110_EO_adult_1_1_cut.fastq.gz CcoxCrh_comrhy110_EO_adult_1_2_cut.fastq.gz CcoxCrh_comrhy110_EO_adult_1_1_paired.fastq.gz CcoxCrh_comrhy110_EO_adult_1_1_unpaired.fastq.gz CcoxCrh_comrhy110_EO_adult_1_2_paired.fastq.gz CcoxCrh_comrhy110_EO_adult_1_2_unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35"
		User time (seconds): 573.52
		System time (seconds): 13.13
		Percent of CPU this job got: 578%
		Elapsed (wall clock) time (h:mm:ss or m:ss): 1:41.48
```
Four trimmed output files:
```
Cco_com101_EO_adult_1_1_paired.fastq.gz
Cco_com101_EO_adult_1_2_paired.fastq.gz
CcoxCrh_comrhy110_EO_adult_1_1_paired.fastq.gz
CcoxCrh_comrhy110_EO_adult_1_2_paired.fastq.gz
```

Wrote script to compute distribution of lengths:
`length.sh`

slurm out:

```
Command being timed: "zcat Cco_com101_EO_adult_1_1_paired.fastq.gz"
		User time (seconds): 70.26
		System time (seconds): 4.92
		Percent of CPU this job got: 70%
		Elapsed (wall clock) time (h:mm:ss or m:ss): 1:46.11

Command being timed: "zcat Cco_com101_EO_adult_1_2_paired.fastq.gz"
		User time (seconds): 73.55
		System time (seconds): 5.16
		Percent of CPU this job got: 72%
		Elapsed (wall clock) time (h:mm:ss or m:ss): 1:48.18

Command being timed: "zcat CcoxCrh_comrhy110_EO_adult_1_1_paired.fastq.gz"
		User time (seconds): 11.88
		System time (seconds): 0.82
		Percent of CPU this job got: 71%
		Elapsed (wall clock) time (h:mm:ss or m:ss): 0:17.68

Command being timed: "zcat CcoxCrh_comrhy110_EO_adult_1_2_paired.fastq.gz"
		User time (seconds): 9.89
		System time (seconds): 0.17
		Percent of CPU this job got: 80%
		Elapsed (wall clock) time (h:mm:ss or m:ss): 0:12.46
```

I checked the resulting tsv files and confirmed that none of the lengths are above 150 bp length, which is a good sign. The left column is how often the read length appears and the right column is read length in bp.

### Plot read distributions
Used Talapas OnDemand for RStudio to plot read distribution:
https://ondemand.talapas.uoregon.edu/ 

Wrote R script:
`Project2_Part2/Distribution.rmd`

Script generated two graphs:

`Project2_Part2/Distribution_Cco_com101_EO_adult_1.png`
`Project2_Part2/Distribution_CcoxCrh_comrhy110_EO_adult_1.png`

### Ran FastQC on trimmed data (paired only)

Used this command:

`pixi run fastqc *paired.fastq.gz -o /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis`

## Bi623-Project2-Part3

### Install additional software for alignment and counting of RNA-seq reads

Used this command:
`pixi add star samtools numpy matplotlib htseq`

Downloaded Campylomormyrus compressirostris genome fasta and gff file from Dryad website:

https://datadryad.org/dataset/doi:10.5061/dryad.c59zw3rcj

### Convert gff file to gtf file

Used agat to convert downloaded gff file to gtf file, since STAR requires a gtf file to align reads.

Referenced this website:
	https://agat.readthedocs.io/en/latest/tools/agat_convert_sp_gff2gtf.html 

Added agat to pixi environment:
`pixi add agat`

This is the format from the website:
`agat_convert_sp_gff2gtf.pl --gff infile.gtf [ -o outfile ]`

Script:
`agar.sh`

slurm out:
```
command : /gpfs/projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis/.pixi/envs/default/bin/agat_convert_sp_gff2gtf.pl --gff campylomormyrus.gff -o campylomormyrus.gtf
date : 09/03/2026 at 10h19m58s
Job done! Bye Bye!

	Command being timed: "agat_convert_sp_gff2gtf.pl --gff campylomormyrus.gff -o campylomormyrus.gtf"
	User time (seconds): 1124.14
	System time (seconds): 15.13
	Percent of CPU this job got: 97%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 19:27.88
```

Checked number of exons in both files to see if gtf file was generated successfully. 

Used these commands:

`cat *gtf | cut -f3 | grep -c  "exon"`

`cat *gff | grep -c  "exon"`

Both resulted in 280886 exons, which is a good sign.

### Generated reference genome with STAR

Used this script:
`Project2_Part3/Scripts/genomeGenerate.sh`

### Aligned to reference genome with STAR

Next, I created another script called `align_refGen.sh` to align the trimmed paired reads to the reference genome.

slurm out:
```
Command being timed: "pixi run STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesCommand zcat --readFilesIn Cco_com101_EO_adult_1_1_paired.fastq.gz Cco_com101_EO_adult_1_2_paired.fastq.gz --genomeDir campylomormyrus_STAR_2.7.11b/ --outFileNamePrefix Cco_com101_EO_adult_1"
	User time (seconds): 4897.98
	System time (seconds): 8.88
	Percent of CPU this job got: 740%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 11:02.53
```
```
Command being timed: "pixi run STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesCommand zcat --readFilesIn CcoxCrh_comrhy110_EO_adult_1_1_paired.fastq.gz CcoxCrh_comrhy110_EO_adult_1_2_paired.fastq.gz --genomeDir campylomormyrus_STAR_2.7.11b/ --outFileNamePrefix CcoxCrh_comrhy110_EO_adult_1"
	User time (seconds): 774.23
	System time (seconds): 2.82
	Percent of CPU this job got: 598%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 2:09.89
```

2 output SAM files:
`Cco_com101_EO_adult_1Aligned.out.sam`
`CcoxCrh_comrhy110_EO_adult_1Aligned.out.sam`

### Report number of mapped and unmapped reads

Wrote script to count and print out the mapped and unmapped reads from each of the 2 resulting SAM files:
`count_alignedReads.py`

Script looked at the bitwise flag to determine if reads are primary or secondary mapping.

Ran these commands:
`srun -A bgmp -p bgmp --time=60:00 --pty bash`

`./count_alignedReads.py -f Cco_com101_EO_adult_1Aligned.out.sam`

For Cco_com101_EO_adult_1, these were the results:

    The number of reads mapped: 90291760
    The number of reads unmapped: 16734296

`./script.py -f CcoxCrh_comrhy110_EO_adult_1Aligned.out.sam`

For CcoxCrh_comrhy110_EO_adult_1, these were the results:

    The number of reads mapped: 16573814
    The number of reads unmapped: 977002

### HTSeq Count

Format from website: https://htseq.readthedocs.io/en/release_0.11.1/count.html 

`htseq-count [options] <alignment_files> <gff_file>`

Used head to look at the first 10 lines of the gff file:
```
##gff-version 3
ptg000927l      .       contig  1       152124  .       .       .       ID=ptg000927l;Name=ptg000927l
ptg000927l      maker   gene    56390   71949   .       +       .       ID=maker-ptg000927l-augustus-gene-0.53;Name=maker-ptg000927l-augustus-gene-0.53
ptg000927l      maker   mRNA    56390   71949   .       +       .       ID=maker-ptg000927l-augustus-gene-0.53-mRNA-1;Parent=maker-ptg000927l-augustus-gene-0.53;Name=maker-ptg000927l-augustus-gene-0.53-mRNA-1;_AED=0.07;_eAED=0.07;_QI=0|0.66|0.62|0.93|0.93|0.87|16|112|1002
ptg000927l      maker   exon    56390   56542   .       +       .       ID=maker-ptg000927l-augustus-gene-0.53-mRNA-1:1;Parent=maker-ptg000927l-augustus-gene-0.53-mRNA-1
ptg000927l      maker   exon    59403   59766   .       +       .       ID=maker-ptg000927l-augustus-gene-0.53-mRNA-1:2;Parent=maker-ptg000927l-augustus-gene-0.53-mRNA-1
ptg000927l      maker   exon    60707   60850   .       +       .       ID=maker-ptg000927l-augustus-gene-0.53-mRNA-1:3;Parent=maker-ptg000927l-augustus-gene-0.53-mRNA-1
ptg000927l      maker   exon    61183   61286   .       +       .       ID=maker-ptg000927l-augustus-gene-0.53-mRNA-1:4;Parent=maker-ptg000927l-augustus-gene-0.53-mRNA-1
ptg000927l      maker   exon    61594   61774   .       +       .       ID=maker-ptg000927l-augustus-gene-0.53-mRNA-1:5;Parent=maker-ptg000927l-augustus-gene-0.53-mRNA-1
ptg000927l      maker   exon    61902   62069   .       +       .       ID=maker-ptg000927l-augustus-gene-0.53-mRNA-1:6;Parent=maker-ptg000927l-augustus-gene-0.53-mRNA-1
```
(Note: ptg000927 is the chromosome and column 9 is the attribute.)

In column 9 (example shown below), 

`ID=maker-ptg000927l-augustus-gene-0.53-mRNA-1:1;`

The numbers at the end before the ";" change so you should use Parent for the `-i` parameter.

slurm out for CcoxCrh_comrhy110_EO_adult_1:

forward
```
Command being timed: "htseq-count -i Parent --stranded=yes CcoxCrh_comrhy110_EO_adult_1Aligned.out.sam campylomormyrus.gff"
	User time (seconds): 560.76
	System time (seconds): 2.68
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 9:26.86
```
reverse
```
Command being timed: "htseq-count -i Parent --stranded=reverse CcoxCrh_comrhy110_EO_adult_1Aligned.out.sam campylomormyrus.gff"
	User time (seconds): 595.72
	System time (seconds): 2.77
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 10:01.09
```

slurm out for Cco_com101_EO_adult_1:

forward
```
Command being timed: "htseq-count -i Parent --stranded=yes Cco_com101_EO_adult_1Aligned.out.sam campylomormyrus.gff"
	User time (seconds): 1413.97
	System time (seconds): 3.66
	Percent of CPU this job got: 98%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 23:53.90
```
reverse
```
Command being timed: "htseq-count -i Parent --stranded=reverse Cco_com101_EO_adult_1Aligned.out.sam campylomormyrus.gff"
	User time (seconds): 2996.11
	System time (seconds): 10.14
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 50:21.49
```

Generated 4 output files:
```
Cco_com101_EO_adult_1_htseqcounts_forstranded.txt
CcoxCrh_comrhy110_EO_adult_1_htseqcounts_forstranded.txt
Cco_com101_EO_adult_1_htseqcounts_revstranded.txt
CcoxCrh_comrhy110_EO_adult_1_htseqcounts_revstranded.txt
```


### Percentage of mapped reads (forward and reverse)

Using `tail`, found that there are 5 lines at the bottom that we don't want to include in our counts.
```
snap_masked-ptg003120l-processed-gene-0.9-mRNA-1        0
snap_masked-ptg003128l-processed-gene-0.5-mRNA-1        0
snap_masked-ptg003215l-processed-gene-0.5-mRNA-1        0
snap_masked-ptg003293l-processed-gene-0.3-mRNA-1        0
snap_masked-ptg003325l-processed-gene-0.4-mRNA-1        0
__no_feature    7614331
__ambiguous     576
__too_low_aQual 11742
__not_aligned   482356
__alignment_not_unique  456713

```
For Cco_com101_EO_adult_1:

Used the following commands to find mapped number of reads for forward and reverse reads.

`head -n -5 Cco_com101_EO_adult_1_htseqcounts_forstranded.txt | awk '{sum+=$2} END {print sum}'`

`head -n -5 Cco_com101_EO_adult_1_htseqcounts_revstranded.txt | awk '{sum+=$2} END {print sum}'`

Used the following commands to find total number of reads.

`awk '{sum+=$2} END {print sum}' Cco_com101_EO_adult_1_htseqcounts_forstranded.txt`

`awk '{sum+=$2} END {print sum}' Cco_com101_EO_adult_1_htseqcounts_forstranded.txt`

Both matched commands resulted in the same total number of reads, which is a good sign.

```
Number of reads mapped, fw: 1292614
Number of reads mapped, rv: 24008842
Total number of reads: 53513028
Percent of reads mapped, fw: 24.16%
Percent of reads mapped, rv: 44.86%
```

For CcoxCrh_comrhy110_EO_adult_1:

Used the following commands to find mapped number of reads for forward and reverse reads.
`head -n -5 CcoxCrh_comrhy110_EO_adult_1_htseqcounts_forstranded.txt | awk '{sum+=$2} END {print sum}'`

`head -n -5 CcoxCrh_comrhy110_EO_adult_1_htseqcounts_revstranded.txt | awk '{sum+=$2} END {print sum}'`

Used the following commands to find total number of reads.

`awk '{sum+=$2} END {print sum}' CcoxCrh_comrhy110_EO_adult_1_htseqcounts_forstranded.txt`

`awk '{sum+=$2} END {print sum}' CcoxCrh_comrhy110_EO_adult_1_htseqcounts_revstranded.txt`

Both matched commands resulted in the same total number of reads, which is a good sign.

```
Number of reads mapped, fw: 209690
Number of reads mapped, rv: 4387460
Total number of reads: 8775408
Percent of reads mapped, fw: 23.90%
Percent of reads mapped, rv: 50.00%
```

This kit was used during library preparation (strand-specific):
https://www.revvity.com/product/nex-rapid-dir-rna-seq-kit-2-0-8rxn-nova-5198-01 