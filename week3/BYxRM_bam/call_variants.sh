#conda activate qb25
#!/bin/bash
cd /Users/cmdb/qb25-answers/week3/BYxRM_bam
echo "" > read_counts.txt
for sample in *.bam
do
    samtools index $sample
    samtools view -c $sample >> read_counts.txt
done 