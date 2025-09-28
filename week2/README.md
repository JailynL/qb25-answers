bowtie2-build sacCer3.fa sacCer3
bowtie -p 4 -x ~/qb25-answers/week3/genomes/sacCer3 \ -U ~/Data/ByxRM/fastq/AO1_01.FQ.GZ -S A01_01.sam
samtools sort -@ 4 -o A01_01.bam A01_01.sam
samtools index A01_01.bam
samtools idxstats A01_01.bam > A01_01.idxstats
