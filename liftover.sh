#!/bin/bash
#To covert the position coordination of minus strand
wd="/gscmnt/gc3024/dinglab/medseq/Noncoding_eQTL/eQTL_in_BRCA/coverage_WGS"
while read lines;
do

id=$(echo $lines| awk -F " " '{print $1}')
sample=$(echo $lines| awk -F " " '{print substr($1,1,12)}')

cd $wd/$sample/log
#Calculate the distance to the start
bsub -oo ${id}_3UTR.lift.log "zcat $wd/$sample/${id}_3UTR.base_coverage.gz | awk -F \"\\t\" '{OFS=\"\\t\"; if (\$6==\"-\") print \$0, \$3-\$2-\$7+1; else print \$0, \$7}' | gzip > $wd/$sample/${id}_3UTR.base_coverage.lift.gz"

for i in 5UTR promoter; do
bsub -oo ${id}_${i}.lift.log "zcat $wd/$sample/${id}_${i}.base_coverage.gz | awk -F \"\\t\" '{OFS=\"\\t\"; if (\$6==\"+\") print \$0, \$3-\$2-\$7+1; else print \$0, \$7}' | gzip > $wd/$sample/${id}_${i}.base_coverage.lift.gz"
  
done

done < $wd/BRCA_WGS_bam.list
