# Mucositis Microbiome
Investigation on the role of microbiome in patients who developed mucositis while under going
allogeneic hematopoietic stem cell transplant (allo HSCT). Stool and oral samples were collected
over time spanning 40 days pre-transplant up to two years post-transplant. Samples underwent 16S
rRNA amplicon sequencing to produce the raw files that will go into this analysis.

## Navigating this repository:
```
project
|- README           # the top level description of content (this doc)
|
|- data             # raw and primary data, are not changed once created
| |- references/    # reference files such as reference genomes or taxonomic databases
| |- raw/           # raw data files or instructions on how to obtain them
| |- processed/     # cleaned data, used to generate figures
| |- working/       # copies of raw data files being worked on or intermediate files required for downstream analysis            
|
|- code/            # scripts with detailed comments for analyses and figure generation
|
|- results          # all output from workflows and analyses
| |- tables/        # text version of tables to be rendered with kable in R
| |- figures/       # graphs, likely designated for manuscript figures
|
|- submission/
| |- manuscript.Rmd # executable Rmarkdown for this study, containing code that generates relevant figures
| |- study.md       # Markdown (GitHub) version of the *.Rmd file
| |- study.pdf      # PDF version of *.Rmd file
| |- citations.bib  # BibTeX formatted references
|
|- exploratory/     # exploratory data analysis for study
| |- notebook/      # preliminary analyses
|
+- Makefile         # executable Makefile for this study, if applicable
```

