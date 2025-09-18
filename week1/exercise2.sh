wget https://hgdownload.soe.ucsc.edu/goldenPath/hg16/bigZips/hg16.chrom.sizes
less hg16.chrom.sizes
grep -v _ hg16.chrom.sizes > hg16-main.chrom.sizes  
touch exercise2.sh    
open exercise2.sh -a "Visual Studio Code"
 bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed 
  wc hg16-1mb.bed 
  mv ~/Downloads/hg16-kc.tsv . 
  wc hg16-kc.tsv 
  cut -f1-3,5 hg16-kc.tsv > hg16-kc.bed 
  head hg16-kc.bed

  
  #How many genes are in hg19?
  cut -f4 hg19-kc.bed | sort -u | wc -l
  # 80270 genes in h19 

#How many genes are in hg19 but not in hg16
#reporting if interval in h19 does not overlap in hg16..remember that -a is the primary file and -b is the reference file 
bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | cut -f4 | sort -u | wc -l
  #42717 are how many genes are in hg19 but not in gh16 


#A possible explantation for why some genes are in hg19 but not in hg16 is due to the nature of the data set. Hg19 was assembled more recently, therefore new sequences could have been added or existing sequences could have been modified as our technology advanced. 

#How many genes are in hg16?
  cut -f4 hg16-kc.bed | sort -u | wc -l 
  # 20767 genes in h16 

#How many genes are in hg16 but not in hg19
bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | cut -f4 | sort -u | wc -l
  # 3339 are how many genes are in hg16 but not in hg19

#A possible explantation for why some some genes appear in hg16 and not hg19 is due to the nature of the assembly. Hg16 was assembled earlier than hg19, so it's possible that some fragments were labeled as genes, or other forms of misannotations, which were fixed in the hg19 assembly. 


