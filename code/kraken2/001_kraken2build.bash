#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 64g
#SBATCH -n 32
#SBATCH -t 1-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# This script is used to build the Kraken2 database used for 16S taxonomic assignment. 
# Kraken2 supports Greengenes, Silva and RDP. We will be using Silva here

# Kraken2 and Bracken are available as a pre-loaded module on Longleaf (module load kraken/2.1.2), 
# however the post-processing scripts from KrakenTools are not. As such, I've chosen to create a conda environment 
# and install Kraken2, Bracken & KrakenTools all under the same environment.

# If you wish to do the same, use the following commands:
# conda create -n kraken2bracken kraken2 bracken krakentools

# For now, we are using the Kraken2 database already created in /proj/andermannlab/projects/KRAKEN2-TESSA/KRAKEN2-TESSA-DB/
# But this database may be updated in the future!

module load anaconda/2021.11
conda_envs=/users/p/r/prisca/miniconda3/envs
conda activate "$conda_envs"/kraken2bracken

kraken2-build --db data/references/kraken2-db/16s_silva --special silva

bracken-build -d data/references/kraken2-db/16s_silva -t 4 -k 35 -l 250
