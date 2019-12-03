sentence <- "Bugün çok güzel bir gün"

sentence_tokens <- sentence %>% 
  tolower %>% 
  removeNumbers %>%
  removePunctuation %>%
  word_tokenizer
it_test <- itoken(sentence_tokens)
dtm_test <- create_dtm(it_test, v_vectorizer)

predict(fit, dtm_test, s = "lambda.min", type="response")
