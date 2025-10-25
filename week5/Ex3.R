horror_movies <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2019/2019-10-22/horror_movies.csv")
View(horror_movies)
#https://github.com/rfordatascience/tidytuesday/blob/main/data/2019/2019-10-22/readme.md

#I am interested in seeing if higher-budget movies get better ratings 
budgetrating <- ggplot(horror_movies, aes(x = log10(parse_number(budget)), y = review_rating)) + #need to parse since data has $
  geom_point(alpha = 1, color = "pink") +
  geom_smooth(method = "lm", color = "black") +theme_minimal()
  labs(title = "Relationship Between Budget and Rating", x = "Log10(Budget USD)", y = "Rating")
ggsave(ggsave("/Users/cmdb/qb25-answers/week5/ex4_V1.png", plot= budgetrating, width = 10, height = 15))
budgetrating 

#Step 3.3 
modelbudget <- lm(review_rating ~ parse_number(budget), data = horror_movies)
summary(modelbudget)


#what are the rating distribution across horror movies?
ratingdistribution <- ggplot(horror_movies, aes(x = review_rating)) + 
  geom_histogram(binwidth = 1, fill = "pink", color ="black") + theme_minimal()
  labs(title = "Distribution of Review Ratings", x = "Rating", y = "Number of Movies")
  ggsave(ggsave("/Users/cmdb/qb25-answers/week5/ex4_V2.png", plot= ratingdistribution, width = 10, height = 15))
ratingdistribution

#compare the distribution between pg13 and R horror movies?
agedrating<- ggplot(horror_movies, aes(x= review_rating, fill = movie_rating)) +geom_density(alpha = 0.6) +
  labs(title = "Rating Distribution by age Rating", x = "Rating", y = "Density") + theme_minimal()
ggsave(ggsave("/Users/cmdb/qb25-answers/week5/ex4_V3.png", plot= agedrating, width = 10, height = 15))
agedrating


