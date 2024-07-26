#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 128g
#SBATCH -n 32
#SBATCH -t 2-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# This script uses QIIME feature classifier to annotate features according to the classifier trained in 04_classifier.bash

module purge
module load qiime2/2022.2

QZA=data/qiime/QZA
QZV=data/qiime/QZV 

qiime feature-classifier classify-sklearn \
  --i-classifier "$QZA"/SILVA-classifier.qza \
  --i-reads "$QZA"/seqs.qza \
  --o-classification "$QZA"/assigned-taxonomy.qza

qiime metadata tabulate \
  --m-input-file "$QZA"/assigned-taxonomy.qza\
  --o-visualization "$QZV"/assigned-taxonomy.qzv

qiime taxa barplot \
 --i-table "$QZA"/table.qza \
 --i-taxonomy "$QZA"/assigned-taxonomy.qza \
 --o-visualization "$QZV"/taxa-bar-plots.qzv
