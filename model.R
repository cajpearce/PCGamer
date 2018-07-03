library(tidyverse)
library(data.table)



reviews = readRDS("all.rds") %>%
    mutate(date = as.POSIXct(date),
           score = as.numeric(as.character(score)),
           item = gsub(" review$","",item)) %>%
    filter(!grepl("GTX [0-9]{3,4}",item),
           !is.na(score)) 


gg = reviews %>% 
    group_by(reviewer) %>%
    filter(n() >= 6
           ,max(date) > as.Date("2017-01-01")
           #,as.numeric(diff(range(as.Date(date)))) < 365
           # ,date > as.Date("2012-01-01")
           )


ggplot(gg,
       aes(date,score,colour=reviewer)) +
    geom_point(alpha = 0.2) +
    geom_smooth(se=FALSE,span = 2) +
    facet_wrap(~reviewer) +
    guides(colour = FALSE) +
    theme_bw() +
    theme(
        panel.grid.minor =  element_blank()
        # ,strip.background = element_rect(fill="white")
        # ,axis.text.x = element_blank()
        # ,axis.text.y = element_blank()
    ) +
    xlab("Date") +
    ylab("Score")



best = gg %>% filter(
    date > as.Date("2016-06-01"),
    score > 85
)
