#!/bin/bash

echo "Region	Distance_to_Start	Sum_of_base_coverage	Count	Average_Read_Depth" > R_input.ori.txt

for i in 3UTR 5UTR promoter; do
cat final.${i} | awk -F "\t" -v x=$i 'NR>1{sum[$2]+=$3;cnt[$2]+=$4}END{OFS="\t";for (i in sum) print x, i, sum[i], cnt[i], sum[i]/cnt[i]}' | sort -k2n >> R_input.ori.txt

done

echo "Region	Distance_to_Start	Sum_of_base_coverage	Count	Average_Read_Depth" > R_input.txt
cat R_input.ori.txt | awk -F "\t" 'NR>1 {if ($2 != 0 && $2 <= 2000) print $0 }' >> R_input.txt

