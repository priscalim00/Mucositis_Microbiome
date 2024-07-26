#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 64g
#SBATCH -n 8
#SBATCH -t 2-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# After annotating our features, we can now export the ASV sequences, feature count table and taxonomic assignments
# into a format that can be read by R for further downstream analysis

module purge
module load qiime2/2022.2

QZA=data/qiime/QZA
QZV=data/qiime/QZV 

# Prior to exporting, you may wish to filter your data to exclude
# 1) samples with low feature counts
# 2) features with low frequency (counts) or prevalence (no. of samples that have this feature)
# 3) features annotated with taxa we don't want/care about i.e. chloroplast, mitochondria, archaea 

## Example of sample based filtering:
qiime feature-table filter-samples \
	--i-table "$QZA"/table.qza \
	--p-min-features 1000 \
	--o-filtered-table "$QZA"/filtered-table.qza


## Example of feature based filtering:
qiime feature-table filter-features \
	--i-table "$QZA"/table.qza \
	--p-min-samples 2 \ #prevalence
	--p-min-frequency 10 \ #frequency
	--o-filtered-table "$QZA"/filtered-table.qza


## Example of taxonomic based filtering:
qiime taxa filter-table \
	--i-table "$QZA"/table.qza \
	--i-taxonomy "$QZA"/assigned-taxonomy.qza \
	--p-exclude mitochondria,chloroplast,d__Archaea,d__Unassigned \
	--p-mode contains \
	--o-filtered-table "$QZA"/filtered-table.qza

export=data/qiime/export
mkdir -p "$export"

# Exporting feature count table (needs to be converted from .biom to .tsv)
qiime tools export \ 
	--input-path "$QZA"/table.qza \
	--output-path "$export" 


biom convert \
	-i "$export"/feature-table.biom \
	-o "$export"/table.tsv \
	--to-tsv

cd "$export"
sed -i '1d' table.tsv
sed -i 's/#OTU ID//' table.tsv
cd ../

# Exporting ASV representative sequences
qiime tools export \
	--input-path "$QZA"/seqs.qza \
	--output-path "$export"

qiime tools export \
	--input-path "$QZA"/assigned-taxonomy.qza \
	--output-path "$export"
