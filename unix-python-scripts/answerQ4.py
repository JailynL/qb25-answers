#!/usr/bin/env python3
from os import chdir
chdir("/Users/cmdb/qb25-answers/unix-python-scripts")

#This is the python script for assignment 3, question 4 
expressiondata = open('GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct') #calling the file manually 
#skip these lines 
a = expressiondata.readline()
b = expressiondata.readline()
#header seperation
header = expressiondata.readline().rstrip("\n").split("\t")
data = expressiondata.readline().rstrip("\n").split("\t")
dict = {}

#len is the size ofthe list in this case 
for i in range(len(header)):
    dict[header[i]] = data[i]
    #print(dict)
metadata = open('GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt') #calling the file manually 

for line in metadata: 
    column = line.rstrip("\n").split("\t") 
    if column[0] in dict.keys():
        sampleID = column[0]
        geneexpression = (dict[column[0]]) 
        tissues = (column[6])
        if float(geneexpression)>0:
            print(sampleID, geneexpression, tissues)

#The first three tissues that have >0 expression?
#1. 0.01776 Brain - Cortex
#2. 0.03757 Adrenal Gland
#3. 0.04667 Thyroid
