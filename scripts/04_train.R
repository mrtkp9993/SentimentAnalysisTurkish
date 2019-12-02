library(caret)

fitControl <- trainControl(method = "cv",
                           number = 5,
                           classProbs = TRUE,
                           verboseIter = TRUE)

fit <- train(x=dtm_train, y=dataset$OriginalEmotion,
             method = "xgbTree", trControl=fitControl,
             nthread=4,
             verbose=TRUE)

trellis.par.set(caretTheme())
plot(fit)
