# PC Gamer

The scripts included in this repo log the progress I made in scraping all the reviews from [PC Gamer](https://www.pcgamer.com/). I had two intentions:

1. Figure out if there were any interesting reviewer trends
2. Figure out what the best games were


## Methods

#### [download.R](https://github.com/cajpearce/PCGamer/blob/master/download.R)

The [PC Gamer archive](https://www.pcgamer.com/reviews/archive) has hyperlinks for all the pockets of reviews that are stored on the site. First these URLs are collated. Then each is opened and the review URLs inside are scraped and stored.


#### [download reviews.R](https://github.com/cajpearce/PCGamer/blob/master/download%20reviews.R)

Each of the reviews fortunately have some common features allowing for easy webscraping. Each of the review URLs from the previous script are opened and the metadata is scraped into a single CSV file.

#### [model.R](https://github.com/cajpearce/PCGamer/blob/master/model.R)

The final script just opens the previous dataset and is where I've done data exploration. Some simple filters were included, such as only looking at reviewers with a minimum number of reviews (for objectivity reasons).

## Results

From the final dataset, the most I could ascertain were the best games and the reviewer trends. Below is a graphic of the reviewer trends over time:

![Reviewers](https://raw.githubusercontent.com/cajpearce/PCGamer/master/images/reviewers.png)

Lucky for [Christopher Livingston](https://twitter.com/screencuisine) and [Andy Chalk](https://twitter.com/AndyChalk) that they had a general increase in videogame quality over their reviewer career.

## Shortfalls

By using the archives, I inadvertedly downloaded _all_ reviews, including hardware reviews. If we only wanted to look at games we might have to rescrape in order to find a filter for videogames only.
