library(dplyr)
library(data.table)
library(text2vec)

train_tokens <- dataset$Entry %>% 
  tolower %>%
  word_tokenizer

it_train <- itoken(train_tokens)
vocab <- create_vocabulary(it_train, stopwords = stopwords)
pruned_vocab <- prune_vocabulary(vocab,
                                 term_count_min = 10, 
                                 doc_proportion_max = 0.5,
                                 doc_proportion_min = 0.001)

v_vectorizer <- vocab_vectorizer(pruned_vocab)
h_vectorizer <- hash_vectorizer(hash_size = 2 ^ 14,
                                ngram = c(1L, 2L))

dtm_train <- create_dtm(it_train, v_vectorizer)
