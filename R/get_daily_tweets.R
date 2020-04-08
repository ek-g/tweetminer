library(rtweet)
library(gmailr)
library(googledrive)

setwd("~/GitHub/tweetminer")

get_token()

yesterday <- format(Sys.Date() - 1, "%Y-%m-%d")

query <- paste("pflege lang:de -filter:retweets",
               paste0("since:", yesterday))

n <- 18000

file_name <- paste0("tweets", yesterday, ".RDS")

file_path <-file.path("data", file_name)

# Get tweets

todays_tweets <- search_tweets(q = query, n = n, retryonratelimit = TRUE)

saveRDS(todays_tweets, file_path)

# Send email (confirmation that the download completed)

my_address <- "eero@kuusisto.de"
gm_auth_configure(path = "gmailr/credentials.json")
gm_auth(my_address)

email <-
  gm_mime() %>%
  gm_to(my_address) %>%
  gm_from(my_address) %>%
  gm_subject(paste("Tweets from", yesterday, "- twitterminer")) %>%
  gm_text_body(paste(nrow(todays_tweets), "Tweets downloaded succesfully with the query:", query)) %>% 
  gm_attach_file(file_path)

gm_send_message(email)

# Upload to google_drive

drive_auth(my_address)

drive_upload(file_path, path = "~/Pflegetweets/", name = file_name)
