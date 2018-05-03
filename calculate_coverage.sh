#!/bin/bash

wd="/gscmnt/gc3024/dinglab/medseq/Noncoding_eQTL/eQTL_in_BRCA/coverage_WGS"
bedd="/gscuser/wliang/eQTL"

while read lines;

do

id=$(echo $lines| awk -F " " '{print $1}')
sample=$(echo $lines| awk -F " " '{print substr($1,1,12)}')
path=$(echo $lines| awk -F " " '{print $2}')

mkdir -p $wd/$sample/log
cd $wd/$sample/log

for i in 3UTR 5UTR promoter;

do
bsub -oo ${id}_${i}.basecov.log "samtools view -u -q 20 $path | coverageBed -d -abam stdin -b $bedd/sorted_ROI_$i.cancer.uniq.bed | gzip > $wd/$sample/${id}_${i}.base_coverage.gz"
done

done < $wd/BRCA_WGS_bam.list
