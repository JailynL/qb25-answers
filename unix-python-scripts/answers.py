#!/usr/bin/env python3
from os import chdir
chdir("/Users/cmdb/qb25-answers/unix-python-scripts")

#This is the python script for assignment 3, question 2 
file = open('ce11_genes.bed') #calling the file manually 
for line in file:
    line = line.rstrip("\n").split("\t") #to make the file readable/ operation friendly
    end = int(line[2])
    start= int(line[1]) #convert to int, and information is in this column
    featuresize = end - start
    orginalscore = int(line[4]) #original score is in this column
    newscore = orginalscore * featuresize #creating new score 
    if line[5] == "+": #defining conditions as "+"
        newscore = (newscore*1) #based if stand is +, multiply by 1
    else:
        newscore = (newscore*-1) #based if the strand is -, multiply by -1
    line[4] = newscore #with a list, you put old variable on left side and on the right side what YOU want to replace it with 
    line = "".join(str(line))
    print(line) #printing within the loop to print out final new score 
#important notes 
#print adds in \n 
#f"" manually add the \n
#.replace is a string, not LIST friendly :(




















