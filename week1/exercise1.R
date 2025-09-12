library (tidyverse)
setwd("/Users/cmdb/qb25-answers/week1")
header <- c( "chr", "start", "end", "count" )
df_kc <- read_tsv( "hg19-kc-count.bed", col_names=header )

ggplot( df_kc , aes(x= start, y = count)) + 
  geom_line( color = "pink") +
  facet_wrap(chr~., scales = "free") + 
  labs (
    x = "Start",
    y = "Count",
    title = "Chromosome") + theme_classic()
ggsave( "exercise1.png" )


