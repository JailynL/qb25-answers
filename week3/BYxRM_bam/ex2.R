#Graph for 2.1
getwd()
allele <- read.table("/Users/cmdb/qb25-answers/week3/BYxRM_bam/AF.txt", header = FALSE)
View(allele)

alleleplot <-ggplot(allele, aes(x = V1)) +
  geom_histogram(
    bins = 11,
    color = "pink"
  ) +
  labs(
    title = "allele frequency spectrum (Distribution 2.2)",
    x = "allele frequency",
    y = "Number of variants"
  ) +
  theme_minimal()
ggsave("Q2.1.png", plot = alleleplot, width = 8, height = 8, dpi = 300)
alleleplot
#This graph follows a bell shaped curve. I would say this is expected as this data set is from variants discovered from haploid progeny in a controlled cross. However, if this was a data set from a natural populations, a bell shaped curve like this would be abnormal

depthdata <- read.table("/Users/cmdb/qb25-answers/week3/BYxRM_bam/DP.txt", header = FALSE)
View(depthdata)
#Graph for 2.3
depth<- ggplot(depthdata, aes(x = V1)) +
         geom_histogram(bins =21, fill = "pink", color = "black") + 
         xlim(0,20) + labs(title = "read depth Distribution Across Samples (2.3)",
         xlab = "read depth",
         ylab = "number of observations")
ggsave("2.3.png", width = 10, height = 15)
print(depth)

#In this plot, it appears as if the read depths have a right skewed distribution meaning most values are at lower depths. This is expected in this data set as sequencing data sets have similar coverage per sample. However, sometimes a tail like this can be observed by bias in sequencing or over amplified reads. 

