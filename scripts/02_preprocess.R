library(dplyr)
library(tm)
library(data.table)

xmldata %>% filter(Condition != "Reject") -> xmldata

dataCorp <- Corpus(VectorSource(as.vector(xmldata$Entry)), 
                   readerControl = list(language="tr"))
meta(dataCorp, "sentiment") <- xmldata$OriginalEmotion
dataCorp <- tm_map(dataCorp, content_transformer(tolower))
dataCorp <- tm_map(dataCorp, content_transformer(removeNumbers))
dataCorp <- tm_map(dataCorp, content_transformer(removePunctuation))
dataCorp <- tm_map(dataCorp, content_transformer(stripWhitespace))

chunk <- 1000
i <- 0
n <- length(stopwordList)
while (i != n) {
  i2 <- min(i + chunk, n)
  dataCorp <- tm_map(dataCorp, removeWords, stopwordList[(i+1):i2])
  i <- i2
}

lengthsof <- nchar(content(dataCorp))
quantile(lengthsof)
idx <- nchar(content(dataCorp)) > 24
idx
dataCorp <- dataCorp[idx]

dt_corpus <- DocumentTermMatrix(dataCorp)
dt_corpus <- removeSparseTerms(dt_corpus, 0.9995)
processed_data <- as.data.table(as.matrix(dt_corpus))
proc_data_dict <- names(processed_data)
processed_data <- cbind(meta(dataCorp, "sentiment"), processed_data)
