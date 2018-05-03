# coverage-TCGA-old
Old script for plotting coverage in UTR and promoter (upstream 2K)
Postion of TSS: `sorted_GRCh37_human_gene.bed`. It is the stop position if it is on negative strand, while start position if it is on positive strand.
Script for lifting over the position (to the start position): `liftover.sh`
Script for generating the average coverage at each position: `average_base_coverage.sh`
Bash script for R: `make_line.R.sh` #You can ignore this. Just passing some parameters to the following R script.
R script for plotting: `plot_line.R`
