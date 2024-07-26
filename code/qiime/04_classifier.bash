#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 128g
#SBATCH -n 32
#SBATCH -t 2-
#SBATCH --mail-type=all
#SBATCH --mail-user=prisca@live.unc.edu

# This script imports the reference database into qiime and trains a classifier based on the region of interest

module purge
module load qiime2/2022.2

QZA=data/qiime/QZA
QZV=data/qiime/QZV 

# In this case, we are using the SILVA 138.1 database. Instructions on how to obtain this database
# is found in /data/references/obtain_silva.bash

# First, we need to import the database as a QIIME artifact
qiime tools import \
	--type 'FeatureData[Sequence]' \
	--input-path data/references/SILVA_138.1_SSURef_NR99_tax_silva.fasta.gz \
	--output-path "$QZA"/silva_138.1_seqs.qza

qiime tools import \
	--type 'FeatureData[Taxonomy]' \
	--input-format HeaderlessTSVTaxonomyFormat \
	--input-path data/references/tax_slv_ssu_138.1.txt.gz \
	--output-path "$QZA"/SILVA-taxonomy.qza

# Next, we need to extract the reads corresponding to our region of interest.
# To do so, you'll need to know the primer sequences used during library prep,
# in our case, it is the V4-V5 region with the corresponding forward & reverse primers: 
qiime feature-classifier extract-reads \
	--i-sequences "$QZA"/silva_138.1_seqs.qza \
	--p-f-primer AYTGGGYDTAAAGNG\
	--p-r-primer CCGTCAATTYHTTTRAGT\
	--o-reads "$QZA"/SILVA-ref-seqs.qza

# Lastly, we need to train a Naive Bayes classifier which will be later used to annotate our features 
qiime feature-classifier fit-classifier-naive-bayes \
	--i-reference-reads "$QZA"/SILVA-ref-seqs.qza \
	--i-reference-taxonomy "$QZA"/SILVA-taxonomy.qza \
	--o-classifier "$QZA"/SILVA-classifier.qza
