#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 64g
#SBATCH -n 16
#SBATCH -t 1-
#SBATCH --mail-type=all
#SBATCH --mail-user=prisca@live.unc.edu

# This script utilizes trim_galore, a wrapper around Cutadapt and FastQC, to remove any adapters and low quality reads. 
# trim_galore is able to auto-detect adapters, making it useful if samples were sequenced a long time ago, and we are 
# unsure of the actual adapter sequence. The default min PHRED score is 20, all bases below this threshold are discarded 

# Input: Deduplicated paired end reads found in data/working/deduped
# Output Trimmed paired end reads that will be depositied in data/working/trimmed

module load trim_galore
module load cutadapt
module load fastqc
module load pigz

mkdir -p data/working/trimmed

rawdir=data/raw
trimmeddir=data/working/trimmed

sample=$1
R1="$sample"_R1.fastq.gz
R2="$sample"_R2.fastq.gz

trim_galore -j 4 --paired "$rawdir"/"$R1" "$rawdir"/"$R2" -o "$trimmeddir"


mkdir -p data/qiime
reads=data/qiime/reads
mkdir -p $reads

cp -uv "$trimmeddir"/"$sample"_R1_val_1.fq.gz "$reads"/"$sample"_trimmed_R1.fastq.gz 
cp -uv "$trimmeddir"/"$sample"_R2_val_2.fq.gz "$reads"/"$sample"_trimmed_R2.fastq.gz 
