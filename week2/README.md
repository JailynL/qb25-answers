bowtie2-build sacCer3.fa sacCer3
bowtie -p 4 -x ~/qb25-answers/week3/genomes/sacCer3 \ -U ~/Data/ByxRM/fastq/AO1_01.FQ.GZ -S A01_01.sam
samtools sort -@ 4 -o A01_01.bam A01_01.sam
samtools index A01_01.bam
samtools idxstats A01_01.bam > A01_01.idxstats

Excercise 2 - Description of the visualization
Using the less function in the BYxRM_GenoData.txt file, I will be looking at the first two markers that appear.
For marker chro1 at 27915, I do not see a difference across all of the 8 BAMS since they all have gray bars
at this specific marker location, same thing with marker 28323. However, when we look at this visulatization
at a much larger scale (zoom out x3), we see different colors across the chromosome, indicating there
are a lot of bases that differ from BY. 
