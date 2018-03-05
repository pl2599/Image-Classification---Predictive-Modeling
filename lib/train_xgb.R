train_xgb <- function(dat_train, label_train, par = NULL){
  
  ### Train a Xgboost classifier using features of training images
  
  ### Input:
  ### - training data including features of training images 
  ###                       and class labels of training images
  ### Output:
  ### - training Xgboost model specification
  
  ### load libraries
  library("xgboost")
  
  if(is.null(par)){
    eta = .3
    gamma = 0
    max_depth = 6
    min_child_weight = 1
    subsample = 1
    colsample_bytree = 1
  } 
  else {
    eta <- par$eta
    max_depth <- par$max_depth
    gamma <- par$gamma
    min_child_weight = par$min_child_weight
    subsample <- par$subsample
    colsample_bytree <- par$colsample_bytree
  }
  
  ### train with Xgboost
  
  xgb_train <- xgboost(data = dat_train,
                       label = label_train,
                       nrounds = 100,
                       eta = eta,
                       gamma = gamma,
                       max_depth = max_depth,
                       min_child_weight = min_child_weight,
                       subsample = subsample,
                       colsample_bytree = 1, 
                       eval_metric = "error",
                       objective = "binary:logistic")
  
  return(xgb_train)
}