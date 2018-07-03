library(tidyverse)
library(data.table)
library(xml2)
library(parallel)

urls = read.csv("review urls.csv",stringsAsFactors = FALSE)

meta.extractor = function(url) {
    z = read_html(url)
    
    reviewer = z %>% xml_find_first("//header//span[@itemprop='name']") %>%xml_text()
    date = z %>% xml_find_first("//header//time[@itemprop='datePublished']") %>% xml_attr("datetime")
    score = z %>% xml_find_first("//header//meta[@itemprop='ratingValue']") %>% xml_attr("content")
    item = z %>% xml_find_first("//header//h1[@itemprop='name headline']") %>% xml_text()
    verdict = z %>% xml_find_first("//p[@class='game-verdict']") %>% xml_text()
    
    data.frame(
        reviewer,
        date,
        score,
        item,
        verdict
    )
}

page.na = data.frame(
    reviewer = NA,
    date = NA,
    score = NA,
    item = NA,
    verdict = NA
)


all.reviews = rbindlist(lapply(urls$review, 
                     possibly(meta.extractor, page.na)),
                     fill=TRUE,
                     use.names = TRUE) 

saveRDS(all.reviews, "all.rds")

