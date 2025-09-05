#!/bin/bash

tail ce11_genes.bed | head -n 2

# chrIII	13768540	13771741	NM_067444.8	515	-
# chrIII	13769876	13769953	NR_003432.1	9	-

#The following answers are for question 1: 

cd /Users/cmdb/qb25-answers/unix-python-scripts
cut -f 1 ce11_genes.bed | sort | uniq -c 

#How many features(lines)? How many features per chr? 
#5460 chrI
#6299 chrII
#4849 chrIII
#21418 chrIV
#12 chrM
#9057 chrV

#How many features per strand?
#cut -f 6 ce11_genes.bed | sort | uniq -c  
#26626 -
#27309 +

#Recalculate ce11_genes.bed scores using Python
chmod +x answers.py 
./answers.py 

#The following are for question 3: 
cut -f 6 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort | tail -n 3
#Which three SMTSDs (Tissue Site Detail) have the most samples?
#2014 Skin
#3326 Brain
#3480 Blood

#How many lines have “RNA”?
grep "RNA" GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | wc -l 
#20017

#How many lines do not have “RNA”?
wc -l GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
echo $(( 22952 - 20017))
#2935

#Transform GTEx data using Python
chmod +x answerQ4.py
./answerQ4.py

