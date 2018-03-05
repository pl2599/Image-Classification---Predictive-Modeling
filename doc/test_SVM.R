############### Inputs:
# "fit_train" = fitted svm model

# "dat_test" = matrix of image features to predict on. Assumes there are both x and label data in here it will only predict on data with same label name as predictors the model was fit on!!! 

# 

# 


############### Outputs:

# "pred" vector of predicted labels 



#######################################


test <- function(fit_train, dat_test){
  
  pred <- predict(fit_train, newdata = dat_test, type = "response")
  
  return(pred)
}