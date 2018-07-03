library(tidyverse)
library(data.table)
library(xml2)


years = 2006:lubridate::year(Sys.Date())
months = 1:12

    
pages = expand.grid(month = months,
                    year = years 
                    ) %>%
    mutate(page = sprintf("https://www.pcgamer.com/reviews/archive/%s/%s/",year, month))

read.page = function(x) {
    retter = read_html(x) %>% 
        xml_find_all("//div[@class='archive-list']/ul/li[not(@class='list-title date-heading')]//a") %>%
        xml_attr("href")
    
    if(length(retter) == 0) {
        retter = NA
    }
    retter
}

all.reviews = rbindlist(lapply(1:nrow(pages),
   function(x) {
        page = pages$page[x]
        urls = possibly(read.page, NA)(page)
       
        data.frame(
            month = pages$month[x],
            year = pages$year[x],
            review = urls
        )
}),fill = TRUE, use.names = TRUE) %>% 
    na.omit() %>% 
    unique()

write.csv(all.reviews, "review urls.csv",row.names = FALSE, na = "")
