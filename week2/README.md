bowtie2-build sacCer3.fa sacCer3
samtools sort -o A01_01.bam A01_01.sam
samtools index A01_01.bam
samtools idxstats A01_01.bam > A01_01.idxstats
