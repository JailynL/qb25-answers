conda activate qb25
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes
less hg19.chrom.sizes 
grep -v _ hg19.chrom.sizes | sed 's/M/MT/' > hg19-main.chrom.sizes
less hg19.chrom.sizes 
ls
 less hg19-main.chrom.sizes
 bedtools makewindows
bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed
ls
ls -l
wc hg19-1mb.bed
ls ~/Downloads 
mv ~/Downloads/hg19-kc.tsv .
ls 
ls -l
% mv ~/Downloads/hg19-kc.tsv . 
% ls -l
wc hg19-kc.tsv 
head hg19-kc.tsv 
cut -f1-3,5 hg19-kc.tsv > hg19-kc.bed
head hg19-kc.bed
bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed > hg19-kc-count.bed 
wc hg19-kc-count.bed 
touch exercise1.sh 
open exercise1.sh 
