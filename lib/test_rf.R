test_rf <- function(fit_train, dat_test){
	pred <- predict(fit_train, newdata=dat_test, type="response")
	return(as.numeric(pred>0.5))
}