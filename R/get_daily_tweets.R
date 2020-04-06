library(rtweet)

setwd("~/GitHub/tweetminer")

get_token()

yesterday <- format(Sys.Date() - 1, "%Y-%m-%d")

query <- paste("pflege lang:de -filter:retweets",
               paste0("since:", yesterday))

n <- 18000


file_to_save <- file.path("data", paste0("tweets", yesterday, ".RDS"))

todays_tweets <- search_tweets(q = query, n = n, retryonratelimit = TRUE)

saveRDS(todays_tweets, file_to_save)
