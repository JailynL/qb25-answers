#!/usr/bin/env python3
import sys
import fasta

my_file = open(sys.argv[1])
contings = fasta.FASTAReader(my_file)

#for mini project q4
# i = 0
# lensum = 0 
# for ident, sequence in contings: #seq is letter 
#     i = i + 1 #counting the number of contigs 
#     lensum = lensum + len(sequence) #counting the number of total length 
#     avglegn = lensum / i  #counting the average length 

# print(i)
# print(lensum)
# print(avglegn)

# print( f"number of contings", i,", total length",lensum,",average length", avglegn)

#The following code is for Mini Project #1 Q5
contiglist = []
contiglen = 0
for ident, sequence in contings:
    consize = len(sequence)
    contiglist.append(consize)
    contiglen = contiglen + consize
print(f"the cumulative length thus far is",contiglen,)

contiglist.sort(reverse= True)


length2= 0 
for length in contiglist:
    length2 = length2 + length
    if length2 < (.5*contiglen):
        continue
    else: 
        break 
print(f"sequence length of the shortest contig at 50% of the total assembly length is",length,)


#IGNORE THE FOLLOWING MATERIALS FROM LECTURE 
#for conting in contings: #reads the conting through the fasta reader 
#    print(contig[0])
#for ident, sequence in assemblies:
#    print( f"Name: {ident}" )
#    print( f”First 20 nucleotides: {sequence[:20]}" )

#my_file = open( sys.argv[1] 9my) #pointer to the file handler 
#contigs = fasta.FASTAREADER #continious sequences that could reassemble
#for line in my_file:
#    print( line ) 
#import sys
#import fasta

#my_file = open( sys.argv[1] )
#assemblies = fasta.FASTAReader( my_file )

#for ident, sequence in assemblies:
#    print( f"Name: {ident}" )
#    print( f"First 20 nucleotides: {sequence[:20]}" )
