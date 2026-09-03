# Lab Notebook: Bi623-Project2
8/27/2026 - Downloaded the two SRR files that was assigned to me 

Project2 Folder Path: /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis

Version:
```
SRA tools 3.4.1
fastqc  0.12.1
cutadapt version 5.2
trimmomatic version 0.41
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
### Ran FastQC on downloaded SRR files:

`pixi run fastqc SRR25* –o /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis`

This generated these files:
```
SRR25630384_1_fastqc.html
SRR25630384_2_fastqc.html
SRR25630408_1_fastqc.html
SRR25630408_2_fastqc.html
```

### Renamed SRR files
Naming convention: Species_sample_tissue\_[ageORsize]\_sample#\_readnumber.fastq.gz (follow the csv from the repository).

Path: `/projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis/RNAseq_meta_campys.csv`

Old File Names:
`SRR25630384_1.fastq.gz`
`SRR25630384_2.fastq.gz`

Renamed to:
```
CcoxCrh_comrhy110_EO_adult_1_1.fastq.gz	
CcoxCrh_comrhy110_EO_adult_1_2.fastq.gz	
	
```
Old File Names:
`SRR25630384_1.fastq.gz`
`SRR25630384_2.fastq.gz`

Renamed to:

```
Cco_com101_EO_adult_1_1.fastq.gz	
Cco_com101_EO_adult_1_2.fastq.gz
```

## Bi623-Project2-Part2

Per FastQC reports, sequences have Illumina Universal Adapters. Found them in the sequence using the following commands:

Adapters for R1: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA

`zcat Cco_com101_EO_adult_1_1.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"`

`zcat CcoxCrh_comrhy110_EO_adult_1_1.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"`


Adapter for R2: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

`zcat Cco_com101_EO_adult_1_2.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`

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

Did another check to see if adapters were cut out:

For Cco_com101_EO_adult_1:

`zcat Cco_com101_EO_adult_1_1_cut.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"`

`zcat Cco_com101_EO_adult_1_2_cut.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`


Adapter for R2: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

`zcat Cco_com101_EO_adult_1_2_cut.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`

`zcat CcoxCrh_comrhy110_EO_adult_1_2_cut.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"`

Did not find any results with the search, which is expected since adapters are now gone.



https://ondemand.talapas.uoregon.edu/ 

Wrote script to trim sequences:

`trimmomatic.sh`

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
Used Talapas OnDemand for RStudio to plot read distribution

Wrote R script:
`Project2_Part2/Distribution.rmd`

Script generated two graphs:

`Project2_Part2/Distribution_Cco_com101_EO_adult_1.png`
`Project2_Part2/Distribution_CcoxCrh_comrhy110_EO_adult_1.png`

### Ran FastQC on trimmed data (paired only)

Used this command:

`pixi run fastqc *paired.fastq.gz -o /projects/bgmp/csung/bioinfo/bi623/Project-2-Electric-organ-RNA-seq-analysis`