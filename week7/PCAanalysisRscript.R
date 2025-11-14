library(tidyr)
library(dplyr)
library(matrixStats)
library(ggplot2)
DATA <- read.delim("/Users/cmdb/qb25-answers/week7/read_matrix.tsv", header = TRUE)
View(DATA)
datamatrix <- as.matrix(DATA)
#View(datamatrix)
#to check if it exisits withing a data matrix I can use %in%
#"P2.4_Rep1" %in% colnames(datamatrix) #responds true, meaning it is a matrix
#column name is the the tissue + replicate
#rows are the genes 
#help(rowSds) #standard deviation estimates for each row(column in a matrix)
mostvaraiablegenes <- rowSds(datamatrix)
sortedgenes <- order(mostvaraiablegenes, decreasing = TRUE)[1:500]
#View(sortedgenes)
datamatrixtoplaywith <- datamatrix[sortedgenes, ] #subset the matrix so befroe the commona specifes rows to kseep, and after the comma is empty meaning keep ALL columns
transposedata <- t(datamatrixtoplaywith) #TA said issue was I used my sortedgenes which only contain gene indices, remember you want to to transpose THE EXPRESSION data 
#View(transposedata)
pca_results <- prcomp(transposedata)
summary(pca_results)
pca_results$x[1,1:2] #look at points
pca_results$sdev #standarddev points 

#step 1.3 PLOTTING 
#creating a data frame  
dataframepc <- as.data.frame(pca_results$x) #converting PCA results into a data frame with all the columns 
dataframepc$sample <- rownames(pca_results$x) #adding a sample column 
#View(dataframepc)

#correcting tissues and replicate columns to fix tissue labels... 
#asked chatgpt to help me create the datafram below because I was having issues getting my inital line to work..
dataframepc <- separate(dataframepc, col = sample, into = c("tissues", "replicate_number"), sep = "_", remove = FALSE) #color by sample, make new columns tissue and replicates, and then split at _ and do not remove sample column  
plot1 <- ggplot(dataframepc, aes(PC1, PC2, color = tissues, shape = replicate_number)) + geom_point(size = 2) + labs(title = "pca plot")
plot1
ggsave("plot1.png",plot1 )

#plotting the variance, followed living coding example and added plots 
datavariance <- tibble(
  PC = seq(1, length(pca_results$sdev), 1),  
  sd = pca_results$sdev
) %>%
  mutate(
    norm_var = sd^2 / sum(sd^2),   
    cum_var = cumsum(norm_var)     
  )
plot2 <- ggplot(datavariance, aes(x = PC, y = norm_var)) +
  geom_bar(stat = "identity", fill = "pink") +
  labs(title = "Variance Explained per PC", x = "Principal Component", y = "Percent Variance") +
  theme_classic()
plot2
ggsave("variance_barplot.png", plot2, width = 7, height = 6)

#doing the Kmean clustering 
#cycling through all 21 samples.. copied code from website 
combined <- datamatrix[, seq(1, 21, 3)] + 
  datamatrix[, seq(2, 21, 3)] + 
  datamatrix[, seq(3, 21, 3)]
combined <- combined / 3
#only want sd bigger thhan 1
sdgenes <- rowSds(combined) #calculating the standrd deviation in each ROW, making a varaible EACH NUMBER IS VARAITION OF GENE ACROSS ALL SAMPLES!!!!
filtersds <- combined[sdgenes > 1,] #ONLY SELECT ROWS HIGHER THAN 1
#set the seed and cluster
set.seed(42) #providing PCA a random number generator to ensure reproducible results 
#USE KMEANS
results<- kmeans(as.matrix(filtersds),  centers=12, nstart=100) #should this be 6?
#to get cluster order
#asked chatgpt to help me understand best way to cluster my datafram, since I was having issues with getting my datafram ordered correctly
ordering = order(results$cluster)
filterorder <- filtersds[ordering,] #gene expressoin filtered
clusterimage<- results$cluster[ordering] #clusrer labels for all genes
#follow code live session
png("heatmap.png", width = 800, height = 600)
heatmap(as.matrix(filterorder),Rowv = NA,Colv = NA, RowSideColors = RColorBrewer::brewer.pal(12,"Paired")[clusterimage],ylab = "Gene")

#exercise 3 
# use filtered data >sd1
cluster1 <- rownames(filtersds)[results$cluster ==1]
head(cluster1)
writeLines(cluster1, "cluster1.txt")
cluster2 <- rownames(filtersds)[results$cluster ==2]
head(cluster2)
writeLines(cluster2, "cluster2.txt")
