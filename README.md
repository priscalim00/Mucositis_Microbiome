# Duke HCT cohort - Stool 16S samples
The samples in this analysis were collected by the Sung Lab at Duke and sequenced by MSKCC targeting the V4-V5 region of the 16S gene.

Raw sample files are found under "/proj/andermannlab/working_files/Duke_16s/Raw_Sequencing/". 
I've renamed the sample files to contain TpID_Timepoint according to `data/sample_manifest.csv`
Note: Some of the raw files only include *.forward.fastq.gz without the corresponding *.reverse.fastq.gz file. 
      Those samples have been excluded from this directory for now. This directory represents 445 patients and 1360 samples

## Workflow:
Step 1 - Preprocessing of reads
1) Generate FastQC & MultiQC reports for all sample files
2) Trim adaptors and low quality reads (TrimGalore)
3) Re-generate FastQC/MultiQC reports to ensure trimming worked

Step 2 - Running QIIME
1) Import reads as QIIME artifact (Do this in batches of about 100-200 samples so that DADA2 doesn't take forever)
2) Denoise and remove chimeras using DADA2
3) Assign taxonomy 

Step 3 - Export QIIME artifacts
1) Feature table
2) Representative sequences (ASVs) 
3) Taxonomy

Step 4 - Taxonomic assignment using Kraken2/Bracken
*This step is optional but Bracken is able to estimate species-level abundance which makes it easier to compare
with shotgun sequencing samples
1) Use QC/trimmed reads as input files for Kraken2/Bracken
