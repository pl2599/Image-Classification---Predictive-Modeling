########################
### Cross Validation ###
########################

### Author: Yuting Ma
### Project 3
### ADS Spring 2016


cv.function <- function(X.train, y.train, d, K) {
  
  n        <- length(y.train)
  n.fold   <- floor(n/K)
  s        <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))  
  cv.error <- rep(NA, K)
  
  for (i in 1:K){
    train.data  <- X.train[s != i,]
    train.label <- y.train[s != i]
    test.data   <- X.train[s == i,]
    test.label  <- y.train[s == i]
    
    par  <- list(depth = d)
    fit  <- train(train.data, train.label, par)
    pred <- test(fit, test.data)  
    cv.error[i] <- mean(pred != test.label)  
    
  }			
  return(c(mean(cv.error), sd(cv.error)))
}

cv_xgboost <- function(dat_train, label_train){
  
  library(xgboost)
  library(caret)
  
  xgb <- xgb.cv(data = dat_train,
                label = label_train,
                eta = 0.01,
                max_depth = 2,
                gamma = .01,
                min_child_weight = 0,
                subsample = .5,
                colsample_bytree = .75,
                nrounds = 100,
                nfold = 5,
                metrics = "error",
                objective = "binary:logistic",
                stratified = TRUE)
  
  # Set up the nuances of the caret's train function
  xgb_control <- trainControl(method = "cv",
                          number = 5,
                          classProbs = TRUE,
                          allowParallel=T,
                          verboseIter = T,
                          returnData = F)
  
  # Set up the parameteres to be tested
  xgb_grid <- expand.grid(nrounds = 100,
                          eta = c(0.01,0.05,0.1),
                          max_depth = c(2,6,10),
                          gamma = c(0, .1, .5),
                          colsample_bytree = .75,
                          min_child_weight = c(0, 1, 2),
                          subsample = .75
                          
  )
  colnames(dat_train) <- 1:ncol(dat_train)
  train_label <- ifelse(label_train==1, "cat", "dog")
  train_label <- as.factor(train_label)
  
  # Tune the parameters
  xgb_tune <- caret::train(x = dat_train,
                    y = as.factor(train_label),
                    method = "xgbTree",
                    trControl = xgb_control,
                    tuneGrid = xgb_grid)
  
  return(xgb_tune$bestTune)


}