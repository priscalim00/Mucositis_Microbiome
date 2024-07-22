#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem=128g
#SBATCH -n 64
#SBATCH -t 2-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# This script works to import all reads into QIIME, creating a QIIME artifact that can be used in DADA2 and 
# QIIME's feature classifer

module purge
module load qiime2/2022.2

QZA=data/qiime/QZA
QZV=data/qiime/QZV 

qiime dada2 denoise-paired \
    --i-demultiplexed-seqs "$QZA"/paired_end_demux.qza \
    --p-trunc-len-f 120 \
    --p-trunc-len-r 120 \
    --p-n-threads 0 \
    --o-representative-sequences "$QZA"/seqs.qza \
    --o-table "$QZA"/table.qza \
    --o-denoising-stats "$QZA"/denoising_stats.qza

qiime feature-table summarize \
  --i-table "$QZA"/table.qza \
  --o-visualization "$QZV"/table.qzv \
 
qiime feature-table tabulate-seqs \
  --i-data "$QZA"/seqs.qza \
  --o-visualization "$QZV"/seqs.qzv
 
qiime metadata tabulate \
  --m-input-file "$QZA"/denoising_stats.qza \
  --o-visualization "$QZV"/denoising_stats.qzv
