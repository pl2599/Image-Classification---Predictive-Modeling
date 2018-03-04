######################################################
### Fit the classification model with testing data ###
######################################################

### Author: Yuting Ma
### Project 3
### ADS Spring 2016

test <- function(fit_train, dat_test){
  
  ### Fit the classfication model with testing data
  
  ### Input: 
  ###  - the fitted classification model using training data
  ###  -  processed features from testing images 
  ### Output: training model specification
  
  ### load libraries
  
  library("gbm")
  
  pred <- predict(fit_train, newdata = dat_test, type = "response")
  
  return(as.numeric(pred > 0.5))
}

