#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 32g
#SBATCH -n 4
#SBATCH -t 1-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# This script functions to combine Bracken outputs into one file

module load anaconda/2021.11
conda_envs=/users/p/r/prisca/miniconda3/envs
conda activate "$conda_envs"/kraken2bracken

bracken_dir=data/working/kracken_bracken/bracken

python "$conda_envs"/kraken2bracken/bin/combine_bracken_outputs.py \
        --files "$bracken_dir"/*_bracken_species.output \
        -o "$bracken_dir"/all_bracken_species.output

python "$conda_envs"/kraken2bracken/bin/combine_bracken_outputs.py \
        --files "$bracken_dir"/*_bracken_genus.output \
        -o "$bracken_dir"/all_bracken_genus.output

python "$conda_envs"/kraken2bracken/bin/combine_bracken_outputs.py \
        --files "$bracken_dir"/*_bracken_order.output \
        -o "$bracken_dir"/all_bracken_order.output



