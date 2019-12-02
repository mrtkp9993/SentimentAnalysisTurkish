library("XML")
library("methods")
library(dplyr)

dataset <- xmlToDataFrame("data/TREMODATA.xml")
dataset %>% filter(Condition != "Reject") -> dataset
dataset$ID <- NULL
dataset$ValidatedEmotion <- NULL
dataset$Condition <- NULL
dataset$VoteDistribution <- NULL

stopwords <- readLines("stopwords.csv")
