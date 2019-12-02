library("XML")
library("methods")

dataset <- xmlToDataFrame("data/TREMODATA.xml")
stopwordList <- readLines("stopwords.csv")
