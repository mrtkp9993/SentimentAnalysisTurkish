library("XML")
library("methods")

xmldata <- xmlToDataFrame("data/TREMODATA.xml")
stopwordList <- readLines("stopwords.csv")
