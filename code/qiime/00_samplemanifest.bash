#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem=50m
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# This script is used to generate the sample manifest needed for importing read files into QIIME

# Move trimmed reads into qiime directory
reads=data/qiime/reads
mkdir -p $reads

cp -uv data/working/trimmed/*.fastq.gz "$reads"

# Generate headers for file
echo -e "sample-id\tforward-absolute-filepath\treverse-absolute-filepath" > data/qiime/sample_manifest.tsv

absolute=/work/users/p/r/prisca/Duke_BMT_16S

# Loop through all files to obtain relevant info
for file in "$reads"/*R1.fastq.gz;
do
	sample=$(basename $file | sed 's/_trimmed_R1.fastq.gz//') 
        R1=$(ls $file)
        R2=${R1//R1.fastq.gz/R2.fastq.gz} #replacing R1 with R2

	echo -e "$sample\t$absolute/$R1\t$absolute/$R2" >> data/qiime/sample_manifest.tsv
done

