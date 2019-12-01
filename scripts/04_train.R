library(caret)

fitControl <- trainControl(method = "repeatedcv",
                           repeats = 1,
                           number = 10,
                           classProbs = TRUE,
                           verboseIter = TRUE)

fit <- train(sentiment ~ ., data = processed_data,
             method = "LogitBoost", trControl=fitControl)

trellis.par.set(caretTheme())
plot(fit)
