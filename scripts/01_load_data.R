library("XML")
library("methods")
library(dplyr)

dataset <- xmlToDataFrame("data/TREMODATA.xml")
dataset <- sample_n(dataset, 10000)
dataset %>% filter(Condition != "Reject") -> dataset
dataset$ID <- NULL
dataset$ValidatedEmotion <- NULL
dataset$Condition <- NULL
dataset$VoteDistribution <- NULL

stop_words <- readLines("stopwords.csv")
