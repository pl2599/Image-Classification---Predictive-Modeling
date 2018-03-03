#########################################################
### Train a classification model with training images ###
#########################################################

### Author: Yuting Ma
### Project 3
### ADS Spring 2016


train <- function(dat_train, label_train, par = NULL){
  
  ### Train a Gradient Boosting Model (GBM) using processed features from training images
  
  ### Input: 
  ###  -  processed features from images 
  ###  -  class labels for training images
  ### Output: training model specification
  
  ### load libraries
  library("gbm")
  
  ### Train with gradient boosting model
  if(is.null(par)){
    depth <- 3
  } else {
    depth <- par$depth
  }
  fit_gbm <- gbm.fit(x = dat_train, y = label_train,
                     n.trees = 2000,
                     distribution = "bernoulli",
                     interaction.depth = depth, 
                     bag.fraction = 0.5,
                     verbose = FALSE)
  best_iter <- gbm.perf(fit_gbm, method = "OOB", plot.it = FALSE)

  return(list(fit = fit_gbm, iter = best_iter))
}

train_xgboost <- function(dat_train, label_train, par = NULL){
  
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
    colsample_bytree <- colsample_bytree
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
                     eval_metric = "mlogloss",
                     objective = "multi:softmax",
                     num_class = 3)
  
  return(xgb_train)
}