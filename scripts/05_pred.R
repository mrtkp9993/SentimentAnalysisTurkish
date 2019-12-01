sentence <- "bugün çok üzgünüm"

dt_sentence <- DocumentTermMatrix(Corpus(VectorSource(sentence)),
                                  control = list(dictionary=proc_data_dict))

pred_df <- as.data.table(as.matrix(dt_sentence))

predict(fit, pred_df)
