# coverage-TCGA-old
### Old script for plotting coverage in UTR and promoter (upstream 2K)
- Postion of TSS: `sorted_GRCh37_human_gene.bed`. It is the stop position if it is on negative strand, while start position if it is on positive strand.
- BED of UTRs: `sorted_GRCh37_human_UTR.bed`. 
- Script for lifting over the position (to the start position): `liftover.sh`
- Script for generating the average coverage at each position: `average_base_coverage.sh`
- Bash script for R: `make_line.R.sh` #You can ignore this. Just passing some parameters to the following R script.
- R script for plotting: `plot_line.R`

### How I generate BED files?
```bash 
#Extracting promoter region from hg19 human genome
#Generate BED files
bedtools$ cat ../GRCh37_human_gene_coordination.csv | awk -F "\t" 'NR>1 {OFS="\t"; print $3, $5, $6, $13, "NA", $4}' > GRCh37_human_gene.bed
bedtools$ cat GRCh37_human_gene.bed | sort -k1.1V | uniq > sorted_GRCh37_human_gene.bed

#Define the promoter region
bedtools$ bedtools flank -i sorted_GRCh37_human_gene.bed -g ../hg19.genome -l 2000 -r 0 -s > ROI_promoter.bed

#Make the BED files of coding sequence
bedtools$ cat ../GRCh37_human_gene_coordination.csv | awk -F "\t" 'NR>1{OFS="\t"; print $3, $7, $8, $13, "NA", $4}' > GRCh37_human_cds.bed

bedtools$ cat GRCh37_human_cds.bed | sort -k1.1V | uniq > sorted_GRCh37_human_cds.bed

#Make the BED files of UTR regions
bedtools$ subtractBed -a sorted_GRCh37_human_gene.bed -b sorted_GRCh37_human_cds.bed > sorted_GRCh37_human_UTR.bed

```

