#!/usr/bin/env bash

# This script provides instructions on obtaining reference files from the SILVA 138.1 release using the following lines:

cd data/references
wget https://ftp.arb-silva.de/release_138_1/Exports/taxonomy/tax_slv_ssu_138.1.txt.gz
wget https://ftp.arb-silva.de/release_138_1/Exports/SILVA_138.1_SSURef_NR99_tax_silva.fasta.gz

# This will subsequently be imported into QIIME2 to create .qza  artifacts and used to annotate ASVs



