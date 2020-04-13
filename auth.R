library(rtweet)

consumerKey = "consumer key"  
consumerSecret = "consumer secret"
accessToken = "access token"
accessSecret = "acceess secret"

token <- create_token(
  app = "howrealareconcepts",
  consumer_key = consumerKey,
  consumer_secret = consumerSecret,
  access_token = accessToken,
  access_secret = accessSecret)