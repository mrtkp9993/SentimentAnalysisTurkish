library("XML")
library("methods")
library(dplyr)

dataset <- xmlToDataFrame("data/TREMODATA.xml")
dataset <- sample_n(dataset, 2000)
dataset %>% filter(Condition != "Reject") -> dataset
dataset$ID <- NULL
dataset$ValidatedEmotion <- NULL
dataset$Condition <- NULL
dataset$VoteDistribution <- NULL

stopwords <- readLines("stopwords.csv")
