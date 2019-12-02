library(caret)

fitControl <- trainControl(method = "cv",
                           number = 10,
                           classProbs = TRUE,
                           verboseIter = TRUE)

fit <- train(sentiment ~ ., data = processed_data,
             method = "LogitBoost", trControl=fitControl,
             verbose=TRUE)

trellis.par.set(caretTheme())
plot(fit)
