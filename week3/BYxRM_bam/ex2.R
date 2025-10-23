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

alleleplot
#This graph follows a bell shaped curve. I would say this is expected as this data set is from variants discovered from haploid progeny in a controlled cross. However, if this was a data set from a natural populations, a bell shaped curve like this would be abnormal

depthdata <- read.table("/Users/cmdb/qb25-answers/week3/BYxRM_bam/DP.txt", header = FALSE)
View(depthdata)
#Graph for 2.3
depth <- hist(as.numeric(depthdata$V1),
     breaks = 21,
     xlim = c(0, 20),
     main = "read depth Distribution Across Samples (2.3)",
     xlab = "read depth",
     ylab = "number of observations",
     col = "pink")
depth

#In this plot, it appears as if the read depths are at the same levels. This indicates that there is uniform sequcing coverage and good quality data.It looks like one big block so it's a very peaked distribution, but it's important to note this is cut off at 20.
