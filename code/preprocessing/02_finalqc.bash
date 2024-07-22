#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem=32g
#SBATCH -n 12
#SBATCH -t 1-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# Re-performing fastqc and multiqc on processed files
# Inputs are processed sequencing files located under data/working/host_removed/
# Outputs are fastqc reports to data/working/fastqc_final

module load fastqc
module load multiqc

mkdir -p data/working/fastqc_final

fastqc -o data/working/fastqc_final data/working/trimmed/*.fastq.gz
multiqc data/working/fastqc_final -o data/working/fastqc_final

