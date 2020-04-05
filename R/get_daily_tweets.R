library(rtweet)

#setwd()

get_token()

yesterday <- format(Sys.Date() - 1, "%Y-%m-%d")
search <- "pflege lang:de -filter:retweets"
range <- paste0("since:", yesterday)
query <- paste(search, range)
#env <- "mining"
n <- 10000
#safedir <- "tweets_pflege"

file_to_save <- file.path("path", paste0("tweets", yesterday, ".RDS"))

todays_tweets <- search_tweets(q = query, n = n)

saveRDS(todays_tweets, file_to_save)