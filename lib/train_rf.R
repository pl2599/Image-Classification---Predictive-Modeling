train_rf <- function(dat_train, label_train){
	library(randomForest)
	fit_rf <- tuneRF(dat_train, label_train, doBest = TRUE)
	return(fit_rf)
}