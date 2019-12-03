library(dplyr)
library(data.table)
library(text2vec)
library(tm)

train_tokens <- dataset$Entry %>%
  tolower %>%
  removeNumbers %>%
  removePunctuation %>%
  word_tokenizer

it_train <- itoken(train_tokens)
vocab <- create_vocabulary(it_train, stopwords = stop_words)
pruned_vocab <- prune_vocabulary(vocab,
                                 vocab_term_max = 1000)

v_vectorizer <- vocab_vectorizer(pruned_vocab)
h_vectorizer <- hash_vectorizer(hash_size = 2 ^ 14,
                                ngram = c(1L, 2L))

dtm_train <- create_dtm(it_train, v_vectorizer)
dtm_train <- normalize(dtm_train, "l1")

save(v_vectorizer, file = "shinyproject/sent_analysis_tr/v_vectorizer.rda")
