library(ggplot2)
#q3.3
data <- (read.table("/Users/cmdb/qb25-answers/week3/BYxRM_bam/gt_long.txt", header=TRUE, sep="\t")) #loading data
sampleofinterest <- subset(data, sample_id == "A01_62" & chrom == "chrII") #looking for certain rows 
sampleofinterest$genotype <- factor(sampleofinterest$genotype, levels = c("0", "1")) #convert the genotype to a factor variable.


plot1 <- ggplot(sampleofinterest, aes(x = as.numeric(pos), y = 0, color = genotype)) +  
  geom_point() +  
  scale_color_manual(values = c("0" = "pink", "1" = "black")) +  
  labs(title = "Sample A01_62 on chromosome chrII",
       x = "chrII position",
       y = "") +                          
  theme_minimal()                    
plot1

#Q3.2 Do you notice any patterns? What do the transitions indicate?
# This graph shows there are multiple recombination points. For example, pink corresponds  to the references alleles while black corresponds to 
#alleles different than the reference alleles. Therefore, this chromosomes has genetic information from both parents due to recombination.

#Q3.3 
data2 <-(read.table("/Users/cmdb/qb25-answers/week3/BYxRM_bam/gt_long.txt", header=TRUE, sep="\t")) #loading data
genotype<- factor(data2$genotype, levels = c("0","1"))
allsamples <- factor(data2$sample_id, levels =unique(data2$sample_id))
View(data2)
plottingallchromosomes <- ggplot(data2, aes(x = as.numeric(pos), y = sample_id , color = factor(genotype))) +  
  geom_point() +  
  facet_grid(.~chrom,scales = "free_x", space = "free_x") + 
  scale_color_manual(values = c("0" = "pink", "1" = "black")) +  
  labs(title = "All samples across chromosomes",
       x = " position",
       y = "Sample ID") +                          
  theme_minimal()   

plottingallchromosomes
