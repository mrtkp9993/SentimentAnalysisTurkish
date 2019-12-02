sentence <- "bugün hava güzel"

dt_sentence <- DocumentTermMatrix(Corpus(VectorSource(sentence)),
                                  control = list(
                                    stemDocument = TRUE,
                                    language = "turkish",
                                    removePunctuation = TRUE,
                                    removeNumbers = TRUE,
                                    dictionary = proc_data_dict))

pred_df <- as.data.table(as.matrix(dt_sentence))

predict(fit, pred_df)
