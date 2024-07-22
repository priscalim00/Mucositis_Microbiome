#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem=16g
#SBATCH -n 12
#SBATCH -t 1-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# This script works to import all reads into QIIME, creating a QIIME artifact that can be used in DADA2 and 
# QIIME's feature classifer

module purge
module load qiime2/2022.2

QZA=data/qiime/QZA
QZV=data/qiime/QZV 

qiime demux summarize \
 --i-data "$QZA"/paired_end_demux.qza \
 --o-visualization "$QZV"/quality_report.qzv
