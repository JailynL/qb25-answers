# My Project

- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248909/caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa.gz
The uncompressed file size is 115M
number of contings 1591 , total length 118549266 ,average length 74512.42363293526

- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248911/caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa.gz
The uncompressed file size is 121M
number of contings 912 , total length 124541912 ,average length 136559.11403508772

- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA53967/caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa.gz
The uncompressed file size is 141M
number of contings 3670 , total length 145442736 ,average length 39630.17329700272


- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA577507/caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa.gz
The uncompressed file size is 127M
number of contings 187 , total length 130480874 ,average length 697758.6844919786

instructions on script: 
1. Make sure that fasta.py is installed in the same working directory 
2. My script is going to expect the contig file (in fasta form) in the same working directory as the python script. 
3. Make sure to create a python script that will run the fasta form, and make sure to import sys and import fasta at the beginning of the python script. 

example 
% ./assembly-metrics.py caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa

