library(rtweet)
library(dplyr)

# fetch and load Twitter OAuth tokens
get_token()

tw = search_tweets(
  '@QiaochuYuan love money gender intelligence morality filter:replies',
  n = 200,
  tweet_mode = "extended"
)

tw_short = tw %>% select(screen_name, text)

write_as_csv(tw_short, 'tweets')