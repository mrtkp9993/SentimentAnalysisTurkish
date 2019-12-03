library(glmnet)
require(doMC)
registerDoMC(cores = 4)

fit <- cv.glmnet(
  x = dtm_train,
  y = dataset$OriginalEmotion,
  family = 'multinomial',
  type.measure = "class",
  nfolds = 5,
  thresh = 1e-3,
  maxit = 1e4,
  parallel = TRUE
)

save(fit, file = "shinyproject/sent_analysis_tr/fit.rda")
