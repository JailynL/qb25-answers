#!/usr/bin/env python3
import sys
import fasta

my_file = open(sys.argv[1])
contings = fasta.FASTAReader(my_file)

i = 0
lensum = 0 
for ident, sequence in contings: #seq is letter 
    i = i + 1 #counting the number of contigs 
    lensum = lensum + len(sequence) #counting the number of total length 
    avglegn = lensum / i  #counting the average length 

print(i)
print(lensum)
print(avglegn)

print( f"number of contings", i,", total length",lensum,",average length", avglegn)


#my_file = open( sys.argv[1] )
#contings = fasta.FASTAReader( my_file )

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
