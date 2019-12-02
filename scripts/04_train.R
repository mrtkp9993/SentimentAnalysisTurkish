library(caret)

fitControl <- trainControl(method = "cv",
                           number = 10,
                           classProbs = TRUE,
                           allowParallel = TRUE,
                           verboseIter = TRUE)

fit <- train(x=dtm_train, y=as.integer(dataset$OriginalEmotion)-1,
             method = "xgbTree", trControl=fitControl,
             verbose=TRUE)

trellis.par.set(caretTheme())
plot(fit)
