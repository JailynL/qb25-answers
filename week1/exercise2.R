
setwd("/Users/cmdb/qb25-answers/week1")
header <- c( "chr", "start", "end", "count" )
dfA <- read_tsv( "hg19-kc-count.bed", col_names=header )
dfB <- read_tsv( "hg16-kc-count.bed", col_names=header )
bind<- bind_rows( hg19=dfA, hg16=dfB, .id="assembly" )
View(bind)

plot2<- ggplot( bind , aes(x = start, y = count, color = assembly, group = assembly))+
  geom_line(linewidth= 0.8) +
  facet_wrap(~chr, scales ="free_x")
  labs (
    x = "start",
    y = "Gene Count",
    title = "Gene distribution across chromosomes",
    color = "Assembly"
    ) + theme_classic()
  
plot2

ggsave( "exercise2.png" )
