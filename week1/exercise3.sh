grep 1_Active nhek.bed > nhek-active.bed
grep 1_Active nhlf.bed > nhlf-active.bed
wc nhlf-active.bed
wc nhek-active.bed
grep 12_Repressed nhlf.bed > nhlf-repressed.bed
grep 12_Repressed nhek.bed > nhek-repressed.bed
wc nhek-repressed.bed
wc nhlf-repressed.bed

#constructing a command to test where there is any overlap in NHEK
bedtools intersect -u -a nhek-active.bed -b nhek-repressed.bed 

#constructing a command to test where there is any overlap in NHLF
bedtools intersect -u -a nhlf-active.bed -b nhlf-repressed.bed 

#regions active in NHEK and NHLF
bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed > activeinboth.bed
wc -l activeinboth.bed 
#11608 activeinboth.bed


#regions active in NHEK but not active in NHLF
 bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed > activeinnhek.bed
 wc -l activeinnhek.bed 
#2405 activeinnhek.bed

#original numbers of lines in nhek-active.bed
wc -l nhek-active.bed
#14013 nhek-active.bed, so yes these two numbers add up 

#a is the primary file, b is checked for overlap with a, -u shows only the features in A that have overlap with B
#-f 1, 100% in -a must overlap -b so only report NHEK active regions within NHLF active 
bedtools intersect -u -f 1 -a nhek-active.bed -b nhlf-active.bed > command1.bed
head command1.bed
#chr1	25558413	25559413

#-F 1, 100% in -b must overlap -a so NHEK active that contain A NHLF region 
bedtools intersect -u -F 1 -a nhek-active.bed -b nhlf-active.bed > command2.bed
head command2.bed
#chr1	19922613	19924613

#combines first two cammands, 100 of a must overlap 100 of b, so it tests EXACT matches between nhek and nhlf
bedtools intersect -u -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed > command3.bed
head command3.bed
#chr1	1051137	1051537

#As the overlap paramaters become stricter, there are fewers features that appear. 


#active in NHEK Active in NHLF
bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed > bothactive.bed   
head bothactive.bed
#chr1	19922613	19924613

#active in NHEK repressed in NHLF
bedtools intersect -u -a nhek-active.bed -b nhlf-repressed.bed > 1EKActive.bed
head 1EKActive.bed
#chr1	1981140	1981540

#repressed in NHEK and NHLF 
bedtools intersect -u -a nhek-repressed.bed -b nhlf-repressed.bed > bothrepressed.bed
head bothrepressed.bed
#chr1	11534013	11538613

#The chromatin state across all nine conditions changes. Ihe active-active, most of them have an active promoter and strong enchancers, but , but at certain points, H1-hESC has a weak enchancer and weak promoter, and HSMM has a weak promoter aswell. 
#In the active-repressed, K562 has an insulator and a weak enhancer, while HUVEC Chromatin state has a posied promoter. Then HepG2 has a strong enchancers, while others either follow a active promoter or repressed state. In the repressed-repressed 
#In the repressed-repressed, most of them are heterochromatin or repressed, while NHLF and K562 has an insulator, and GM12878 has a weak enhancer. 