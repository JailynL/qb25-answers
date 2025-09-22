touch exercise4.sh
open exercise4.sh 
open exercise4.sh -a "visual studio code"
bedtools intersect -a hg19-kc.bed -b snps-chr1.bed -c > snpgenecount.bed

#gene that has the high the most SNP's
sort -nr -k5 snpgenecount.bed | head -n 1
#chr1	245912648	246670581	ENST00000490107.6_7	5445
#name ENST00000490107.6_7	
#human name: SMYD3
#position :chr1:245,912,649-246,670,581
#size : 757,933 bp.
#exon count : 5445

#creating a subset of SNPs 
bedtools sample -n 20 -seed 42 -i snps-chr1.bed > snps20.bed

#use bedtools to sort the subset of SNPs then do it to hg19-kc.bed
 bedtools sort -i snps20.bed > snps20sort.bed
 bedtools sort -i hg19-kc.bed > hg19-kcsort.bed

 #using bedsorts to break ties 
bedtools closest -a snps20sort.bed -b hg19-kcsort.bed -d -t first > snpsclosest.bed
less -s snpsclosest.bed


#14 of the SNPs are inside of a gene 
#The range is from 1664 to 22944 (1664,4407,6336,15658,22944)
