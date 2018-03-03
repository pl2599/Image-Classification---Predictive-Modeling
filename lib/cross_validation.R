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

cv.xgboost <- function(dat_train, label_train, par, K){
  
  xgb <- xgb.cv(data = dat_train,
                label = label_train,
                eta <- par$eta,
                max_depth <- par$max_depth,
                gamma <- par$gamma,
                min_child_weight = par$min_child_weight,
                subsample <- par$subsample,,
                colsample_bytree <- colsample_bytree,
                nrounds = 100,
                nfold = K,
                num_class = 3,
                early_stopping_rounds = 100,
                metrics = "mlogloss",
                objective = "multi:softmax",
                stratified = TRUE)
  
  best_iter <- xgb$best_iteration
  cv.err <- xgb$evaluation_log[iter, ]$test_merror_mean
  cv.sd <- xgb$evaluation_log[iter, ]$test_merror_std
  
  return (list(cv.error = cv.err, cv.sd = cv.sd))
}