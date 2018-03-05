train_rf <- function(dat_train, label_train){
	
	# Load necessary library
	library(randomForest)
		
	# Use tuneRF which automatically conducts cross validation on mtry parameter
	fit_rf <- tuneRF(dat_train, label_train, doBest = TRUE)
	return(fit_rf)
}