sentence <- "Özlediğim biriyle görüşmek"

sentence_tokens <- sentence %>% tolower %>% word_tokenizer
it_test <- itoken(sentence_tokens)
dtm_test <- create_dtm(it_test, v_vectorizer)

predict(fit, dtm_test)
