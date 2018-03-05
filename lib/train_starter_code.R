#########################################################
### Train a classification model with training images ###
#########################################################

### Author: Yuting Ma
### Project 3
### ADS Spring 2016

## Questions: 
# What form of object does GBM.fit take as input? A:  x= data.frame of predictors
#y = data fram of labels. n_rows of both must be the same.
# As output to gbm.perf?

# train.R returns a fitted (i.e estimated parameters) model object from 
#gbm.fit() [the fitted model can be used with a predict function to get
#test predictions] and ....


# par = hyper-parameter
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
