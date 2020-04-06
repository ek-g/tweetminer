library(dplyr)
library(purrr)
library(lubridate)

tweet_files <- list.files(path = "data",
                        pattern = "tweets.*\\.RDS",
                        full.names = TRUE)

all_tweets <- tweet_files %>% 
  map(readRDS) %>% 
  bind_rows()