#!/usr/bin/env python3

#This asignment I was working on it for a while but my loops never stopped running, it was running infinitely....
#I had to ask ChatGPT to help me with this assignment, but I understand now my mistakes with my original code. 
#I commented out what I was trying to do orginally do for references... 

import sys
import numpy as np
from fasta import readFASTA


#====================#
# Read in parameters #
#====================#
# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code
fasta = sys.argv[1] #fasta file 
sigma_file = sys.argv[2] #text file, corresponding to amino acid or nucleotide
gappenalty = int(sys.argv[3]) #we establish this
out_file = sys.argv[4] #text

# Read the scoring matrix into a dictionary
fs = open(sigma_file)
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

# Read in the actual sequences using readFASTA
input_sequences = readFASTA(open(fasta))
seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]
m = len(sequence1) #gives me length of sequence one and store in variable
n = len(sequence2) #give me length of sequence two and store in variable 

#=====================#
# Initialize F matrix #
#=====================#
#create an empty F matrix, np.zeros creates an array of where every element is a 0, 
#F_matrix_optimal = np.zeros((len(sequence1)+1, len(sequence2)+1), dtype=int)
#=============================#
# Initialize Traceback Matrix #
#=============================#
#F_matrix_traceback = np.empty((len(sequence1)+1, len(sequence2)+1), dtype=str)
#F_matrix_traceback[0, 0] = "complete"

F = np.zeros((m + 1, n + 1), dtype=float) #creates matrix with zeros, add extra columns/row for needman to start
T = np.empty((m + 1, n + 1), dtype=str) #similar ideas as above, but tells us which moved led to optimal score 
F[0, 0] = 0 #algn to 0
T[0, 0] = "done" #marks end point 
for i in range(1, m + 1): #initial column
    F[i, 0] = gappenalty * i
    T[i, 0] = "v"   

for j in range(1, n + 1): #initial row
    F[0, j] = gappenalty * j
    T[0, j] = "h"   
#===================#
# Populate Matrices #
#===================#
#for i in range(1, len(sequence1)+1): # loop through rows
#	for j in range(1, len(sequence2)+1): # loop through columns
#		d = F_matrix_optimal[i-1, j-1] + sigma[(sequence1[i-1], sequence2[j-1])]
#		h = F_matrix_optimal[i,j-1] + gappenalty
#		v = F_matrix_optimal[i-1,j] + gappenalty
#		F_matrix_optimal[i,j] = max(d,h,v)

for i in range(1, m + 1): #Loops through all cells of the F matrix, except the first row and column m and n correspond to specific sequence
    for j in range(1, n + 1):
		#disgnoal score 
        d = F[i - 1, j - 1] + sigma[(sequence1[i - 1], sequence2[j - 1])]
        h = F[i, j - 1] + gappenalty #horizontal
        v = F[i - 1, j] + gappenalty #vertical score 

        best = max(d, h, v) #pick the best score of all three to find optimal score
        F[i, j] = best

        if best == d: #fill the treaceback to record which move led to optimal score
            T[i, j] = "d"
        elif best == h:
            T[i, j] = "h"
        else:
            T[i, j] = "v"
# #========================================#
# # Follow traceback to generate alignment #
# #========================================#
# #h score traceboack is = d so you need to keep tack the dignao move, then it will print out d h v so if i is 4 and j is 5 traceback is = to d. so we know sequnce 4 is a match the index value matters cuz you can match up to the orginial sequence
# 		if F_matrix_optimal[i,j] == d:
# 			F_matrix_traceback[i,j] = "d" #direcition is diagnoal
# 		elif F_matrix_optimal[i,j] == h:
# 			F_matrix_traceback[i,j] = "h" #left direction, gap in seq 1
# 		else:
# 			F_matrix_traceback[i,j] = "v" #up and gap in seq2 
# #so if i -4 and j-5 and the move was diangla it would be =d, so 4 seq d alignes with 5 seq 2 so it goes from 4,5 -> 3,4

# # The aligned sequences are assumed to be strings named sequence1_aligment
# # and sequence2_alignment in later code
# i = len(sequence1)
# j = len(sequence2)
# sequence1_alignment = '' 
# sequence2_alignment = ''
# #gap in sequence 1 is vertical 
# #gap in sequece 2 is horitzonal
# #following live code and went to OH 
# while F_matrix_traceback[i, j] != "done":
# 	move = F_matrix_traceback[i,j]
# 	if move == "d":
# 		sequence1_alignment = sequence1[i-1] + sequence1_alignment
# 		sequence2_alignment = sequence2[j-1] + sequence2_alignment
# 		i -= 1
# 		j -= 1
# 	elif move== "h":
# 		sequence1_alignment = '-' + sequence1_alignment
# 		sequence2_alignment = sequence2[j-1] + sequence2_alignment
# 		j -= 1
# 	elif move == "v":
# 		sequence1_alignment = sequence1[i-1] + sequence1_alignment
# 		sequence2_alignment = '-' + sequence2_alignment
# 		i -= 1

#build sequence form the end since it stops from top left to bottom righ
i, j = m, n
seq1_align = ""
seq2_align = ""
while i > 0 or j > 0:  # loop until both i and j reach 0, trackback loop
    if i > 0 and j > 0 and T[i, j] == "d": #diagonal move 
        seq1_align = sequence1[i - 1] + seq1_align
        seq2_align = sequence2[j - 1] + seq2_align
        i -= 1
        j -= 1
    elif j > 0 and (i == 0 or T[i, j] == "h"): #horiztonal more 
        seq1_align = "-" + seq1_align
        seq2_align = sequence2[j - 1] + seq2_align
        j -= 1
    elif i > 0 and (j == 0 or T[i, j] == "v"): #vertical move 
        seq1_align = sequence1[i - 1] + seq1_align
        seq2_align = "-" + seq2_align
        i -= 1


#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity = ""
for a, b in zip(seq1_align, seq2_align): #loop through sequences 
    identity += "|" if a == b else " " #add matches or mismatches

#dont need o use the matrix, and you can just use traceback to find the normal allignement 

#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

with open(out_file, "w") as out:
    for k in range(0, len(identity), 100):
        out.write(seq1_align[k:k+100] + "\n") #wrote 1st seqience at k index 
        out.write(identity[k:k+100] + "\n") #do the same for idenetiy and wrtie up to 100 character
        out.write(seq2_align[k:k+100] + "\n\n") #same for second sequences 

#=============================#
# Calculate sequence identity #
#=============================#
#count gaps 
gap1 = seq1_align.count("-")
gap2 = seq2_align.count("-")

#asked chatgpt to help me with code below. 
matches = sum(1 for a, b in zip(seq1_align, seq2_align) if a == b)

# Percent identity for each sequence
pid1 = matches / (len(seq1_align) - gap1) * 100
pid2 = matches / (len(seq2_align) - gap2) * 100
score = F[m, n] #allignment score 
#======================#
# Print alignment info #
#======================#
print("Gaps in Sequence 1:", gap1)
print("Gaps in Sequence 2:", gap2)
print(f"Percent identity (Seq1): {pid1:.2f}%")
print(f"Percent identity (Seq2): {pid2:.2f}%")
print("Alignment score:", score)
# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score
