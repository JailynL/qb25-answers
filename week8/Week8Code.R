library(DESeq2)
library(tidyverse)
library(broom)

#loading data and importing libraries
genedata<- read_delim("/Users/cmdb/qb25-answers/week8/gene_locations.txt")
metadata <- read_delim("/Users/cmdb/qb25-answers/week8/gtex_metadata_downsample.txt")
bloodata <- read_delim("/Users/cmdb/qb25-answers/week8/gtex_whole_blood_counts_downsample.txt")
bloodata <- column_to_rownames(bloodata, var = "GENE_NAME")
metadata <- column_to_rownames(metadata, var = "SUBJECT_ID")

#head(bloodata[,1:5])
#heat(metadata)

# check to make sure the metadata correspond to the count data
table(colnames(bloodata) == rownames(metadata))

#FOR FSEQ2 objects variable needs to be converted to a factor 
metadata$SEX <- factor(metadata$SEX)
metadata$DTHHRDY <- factor(metadata$DTHHRDY)
#rowgenes[1:5,] to view 

# create DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = bloodata,
                              colData = metadata,
                              design = ~ SEX +  DTHHRDY + AGE)
# apply VST transformation
vsd <- vst(dds)

# apply and plot PCA for the three intergroups 
plotPCA(vsd, intgroup = "SEX")
plotPCA(vsd, intgroup = "DTHHRDY")
plotPCA(vsd, intgroup = "AGE")

#What proportion of variance in the gene expression data is explained by each of the first two principal components? Which principal components appear to be associated with which subject-level variables?
#In this graph, PC1 explains 48% variance and PC2 explains 7% of the variance. 
# In the PCA seperated by SEX and AGE, the points are mixed together suggesting that neither
#align with the variation in the dataset. However, in contrast, PCA separated by DTHHDRY show separation along 
# ventilator cases cluster towards the right side of the plot, while natural death causes towards the left.
#This indicates that DTHHRDY is the subject level variable strong associated with PC1. 

#step 2.1 
vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(metadata, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
m1
#Does WASH7P show significant evidence of sex-differential expression (and if so, in which direction)? Explain your answer.
#The SEXmale has a pvalue of 0.279 and is not statistically significant so there is no expression differences 
#of WASH7P genes between males and females. 

m2 <- lm(SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>% tidy()
m2
#Does SLC25A47 show significant evidence of sex-differential expression (and if so, in which direction)? Explain your answer.
#The SEXmale has a pvalue of 0.0257 and is  statistically significant so there is an expression differences 
#of SLC25A47 genes between males and females. The coefficient of SEXmale is 0.518, indicating that males have higher expression of this gene compared to females. 

#step 2.2 
dds <- DESeq(dds)
resultsNames(dds)

#step 2.3
res_sexdifference <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")  %>% arrange(padj)

Sexpvalue <- res_sexdifference %>% filter(!is.na(padj) & padj < 0.1) %>% nrow()
Sexpvalue
#How many genes exhibit significant differential expression between males and females at a 10% FDR?
#262 genes exhibit significant differential expression between males and females at a 10% FDR.

#colnames(res_sexdifference)
#colnames(genedata)
# mappings of genes to chromosomes
mappinggenes <- left_join(res_sexdifference, genedata, by = c("GENE_NAME" = "GENE_NAME")) %>%
  arrange(padj)
View(mappinggenes)

#To look at the values for males, I am looking for a large positive log2 fold change which means it's more expressed in males. 
#When I use the head-function the top genes (most unregulated genes) are RPS4Y1,UTY,KDM5D,DDX3Y,PRKY,EIF1AY, which are located on the Y gene, indicating they are male-specific. 
#To look at the values for females, I am looking for a large negative log2 fold change which means it's more expressed in females 
#On the X chromosome, indicating unregulated genes in females, are XIST, TSIC, EIF253 and others.. 
#At the top of the list, I would say there are more male-linked genes which makes sense as they are linked to the Y chromosome, but overall, there is a mix of top gene hits across sex.  
#For gene WASH7P, the log2fold change is 0.089 and located on chromosome 1, which is consistent as earlier we did not see sex-specific expression. 
#On the other hand, SLC35A47 does show a higher positive log2fold change value of 3.06 and is located on chromosome 14, indicating that the expression is higher in male, therefore, sex-associated expression.
#Having a stringent FDR threshold reduces the number of false positives but increases false negatives as genes with high expression will no longer meet this strict cutoff. However, 
#if you have a large 20% threshold, you have a higher change of false positives but decrease false negatives, as more genes can be included in the analysis. 
#Typically, power to detect differences in expression increases with larger sample sizes as it reduces noise, and effect size makes expressoin differences easier to detect. 

#2.4
#coppy code from class
res_death <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes") %>%
  as_tibble(rownames = "GENE_NAME")  %>% arrange(padj)
#copy code from class, but make sure to get rid of NA 
deathpvalue <- res_death %>% filter(!is.na(padj) & padj < 0.1)
nrow(deathpvalue)

#How many genes are differentially expressed according to death classification at a 10% FDR?
# 16069 genes are differentially expressed according to death classification at a 10% FDR?
metadatachanges <-metadata
#ONLY WORKS ON FACTORS
metadatachanges$SEX <- factor(metadatachanges$SEX)
metadatachanges$DTHHRDY <- factor(metadatachanges$DTHHRDY)
metadatachanges$AGE <- factor(metadatachanges$AGE)
metadatachanges$SEX <- sample(metadatachanges$SEX)
#keep the same as earlier just change the variable 
changingdds <- DESeqDataSetFromMatrix( countData = bloodata, 
                                       colData = metadatachanges, 
                                       design = ~ SEX + DTHHRDY + AGE )
#run it
dds_permutation <- DESeq(changingdds)

#store results
results_change<- results(dds_permutation, name = "SEX_male_vs_female") %>%
  as_tibble(rownames = "GENE_ID") %>% arrange(padj)


count <- results_change %>% filter(!is.na(padj) & padj < 0.1) %>% nrow()
count

#How many genes appear “significant” in this permuted analysis at a 10 % FDR? 
#226 genes appear “significant” in this permuted analysis at a 10 % FDR

# Compare this number to the count from your real (non-permuted) analysis.
#In my real (non-permuted) analysis I got 262 significant genes. 

#What does this suggest about how well the FDR threshold controls the expected rate of false discoveries in large-scale RNA-seq experiments?
#Due to this permuted data set having a smaller number of significant genes, it suggests that the genes from my real analysis was mostly real postivies. 
# This shows how important the FDR threshold is for controlling false postivies or negatives and is helpful with large datasets, as these data sets can have genes that appear significant but are not. 

#Exercise 3

#copied code in live coding + filter 
plot <- ggplot(mappinggenes, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(aes(color = padj < 0.1 & abs(log2FoldChange) > 1)) +
  scale_color_manual(values = c("FALSE" = "pink", "TRUE" = "black"),
                     name = "Significant") +
  theme_minimal()

plot

ggsave("volcanoplot.png", plot = plot, width = 10, height = 10)

#in the graph, the pink points are accumulated at 0 the middle suggesting that most these genes are not being expressed differently across sex. 
# However, the black points are differentially expressed and significantly expressed. These black spots are represent significant genes, for instance, on the left side expression is higher in one group while on the right side, expression is higher in another. 


