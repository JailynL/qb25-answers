#!/usr/bin/env python3

# #code below is for 3 coverage 
# import numpy as np
# from scipy.stats import poisson, norm

# genomesize = 1_000_000
# readlength = 100
# coverage = 3
# num_reads = (genomesize*coverage) // readlength

# genomecoverage = np.zeros(genomesize, dtype = int)

# for i in range(num_reads):
#     startpos = np.random.randint(0,genomesize-readlength+1)
#     endpos = startpos + readlength
#     genomecoverage[startpos:endpos] += 1

# np.savetxt("coverage.txt", genomecoverage, fmt="%d")
# maxcoverage = max(genomecoverage)
# xs = list(range(0, maxcoverage+1))

# poisson_estimates = poisson.pmf(xs, mu = coverage)

# normal_estimates = norm.pdf(xs, loc=coverage, scale=np.sqrt(coverage))

# np.savetxt("poisson_estimates.txt", np.column_stack([xs, poisson_estimates]))
# np.savetxt("normal_estimates.txt", np.column_stack([xs, normal_estimates]))


# #code below is for 10 coverage 
# import numpy as np
# from scipy.stats import poisson, norm

# genomesize = 1_000_000
# readlength = 100
# coverage = 10
# num_reads = (genomesize*coverage) // readlength

# genomecoverage = np.zeros(genomesize, dtype = int)

# for i in range(num_reads):
#     startpos = np.random.randint(0,genomesize-readlength+1)
#     endpos = startpos + readlength
#     genomecoverage[startpos:endpos] += 1

# np.savetxt("coverage10x.txt", genomecoverage, fmt="%d")
# maxcoverage = max(genomecoverage)
# xs = list(range(0, maxcoverage+1))

# poisson_estimates = poisson.pmf(xs, mu = coverage)

# normal_estimates = norm.pdf(xs, loc=coverage, scale=np.sqrt(coverage))

# np.savetxt("poisson_estimates.txt", np.column_stack([xs, poisson_estimates]))
# np.savetxt("normal_estimates.txt", np.column_stack([xs, normal_estimates]))

#code below for 30x coverage
# import numpy as np
# from scipy.stats import poisson, norm

# genomesize = 1_000_000
# readlength = 100
# coverage = 30
# num_reads = (genomesize*coverage) // readlength

# genomecoverage = np.zeros(genomesize, dtype = int)

# for i in range(num_reads):
#     startpos = np.random.randint(0,genomesize-readlength+1)
#     endpos = startpos + readlength
#     genomecoverage[startpos:endpos] += 1

# np.savetxt("coverage30x.txt", genomecoverage, fmt="%d")
# maxcoverage = max(genomecoverage)
# xs = list(range(0, maxcoverage+1))

# poisson_estimates = poisson.pmf(xs, mu = coverage)

# normal_estimates = norm.pdf(xs, loc=coverage, scale=np.sqrt(coverage))

# np.savetxt("poisson_estimates.txt", np.column_stack([xs, poisson_estimates]))
# np.savetxt("normal_estimates.txt", np.column_stack([xs, normal_estimates]))

#Code for 2.1 Below 
reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']
k = 3
graph = set()


for read in reads:
  for i in range(len(read) - k):
     kmer1 = read[i: i+k]
     kmer2 = read[i+1: i+1+k]
     edge = f"{kmer1} -> {kmer2}" 
     graph.add(edge)

for edge in sorted(graph):
    print(edge)
#I did ask ChatGPT to help me with the code for the following plots, as I was having difficulties getting it to run. 
with open("debruijn_edges.txt", "w") as f:
    for edge in sorted(graph):
        f.write(edge + "\n")
    
with open("debruijn.dot", "w") as f:
    f.write("digraph G {\n")
    for edge in sorted(graph):
        kmer1, kmer2 = edge.split(" -> ")
        f.write(f"    {kmer1} -> {kmer2};\n")
    f.write("}\n")
