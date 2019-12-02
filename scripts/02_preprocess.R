library(dplyr)
library(tm)
library(data.table)

dataset %>% filter(Condition != "Reject") -> dataset

corpus <- Corpus(VectorSource(as.vector(dataset$Entry)), 
                 readerControl = list(language="tr"))
meta(corpus, "sentiment") <- dataset$OriginalEmotion
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeWords, stopwordList)

corpusCopy <- corpus
corpus <- tm_map(corpus, stemDocument, "turkish")
corpus <- tm_map(corpus, 
                 content_transformer(stemCompletion), 
                 dictionary=corpusCopy)

dt_corpus <- DocumentTermMatrix(corpus, control = list(stemming=TRUE))
processed_data <- as.data.table(as.matrix(dt_corpus))
proc_data_dict <- names(processed_data)
processed_data <- cbind(meta(corpus, "sentiment"), processed_data)
