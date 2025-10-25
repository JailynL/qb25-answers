library(tidyverse)
library(broom)
library(ggplot2)

#Exercise 1: Wrangle the Data 
mutationdata <-read_csv("/Users/cmdb/qb25-answers/week5/aau1043_dnm.csv")
View(mutationdata) 
data <- mutationdata %>% filter (!is.na(Phase_combined)) #we want to remove rows with no information
View(data) 
datanew <- data %>% group_by(Proband_id, Phase_combined) %>% summarize( sample = n())%>% pivot_wider(names_from = Phase_combined, values_from = sample ) #counting the number of rows in the group and creating a column with that new count 
View(datanew)
parentaldata <- read_csv("/Users/cmdb/qb25-answers/week5/aau1043_parental_age.csv")
View(parentaldata)
merged_data <- merge(parentaldata, datanew, by = "Proband_id", all.x = TRUE) #all.x = TRUE allows for a left join meaning that all rows from the first table will be there  
View(merged_data)

#2.1 - visualize relationships
#Maternal Plot
momplot <- ggplot(merged_data, aes(x= mother, y= Mother_age)) + geom_point (color = "pink") + labs(
                title = "Step 2.1 Plot Maternal",
                x = "count of maternal DNMs",
                y = "count of maternal age")
momplot
ggsave("/Users/cmdb/qb25-answers/week5/ex2_a.png", plot =momplot,  width = 10, height = 15)


#Paternal Plot
dadplot <- ggplot(merged_data, aes(x= father, y= Father_age)) + geom_point (color = "blue") + labs(
  title = "Step 2.1 Plot Paternal",
  x = "count of paternal DNMs",
  y = "count of paternal age")
dadplot
ggsave("/Users/cmdb/qb25-answers/week5/ex2_b.png",plot =dadplot, width = 10, height = 15)

#Step 2.2 OLS- maternal age vs maternal DNMs
linearmodel <- lm(merged_data$mother ~ merged_data$Mother_age, data = merged_data) #first is the response variable vs predictor varaible)
summary(linearmodel)

#Step 2.3 OLS- paternal age vs paternal DNMs
Paternallinearmodel <- lm(merged_data$father ~ merged_data$Father_age, data = merged_data) #first is the response variable vs predictor varaible)
summary(Paternallinearmodel)

#Step 2.4 Making predication 
newpaternalpredication <- tibble(Father_age = 50.5)
predict(Paternallinearmodel, newdata = newpaternalpredication)

#step 2.5 Compare Distributions on maternal vs parental DNMs
plot2 <- merged_data %>% pivot_longer(c(mother,father), names_to = "Parent_Type", values_to = "dnm_count") %>%
  ggplot(aes(x= dnm_count, fill = Parent_Type)) +
  geom_histogram(alpha = 0.3, position = "identity") + scale_fill_manual(values =c("father" = "blue", "mother" = "pink")) +labs(
    title = "Maternal Versus Paternal DNMs",
    x = "Number of DNMs",
    y = "Count of Probands")
plot2
ggsave("/Users/cmdb/qb25-answers/week5/ex2_c.png", plot= plot2, width = 10, height = 15)

