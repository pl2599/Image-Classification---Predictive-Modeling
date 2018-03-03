train_lg <- function(dat_train, label_train){
	fit_lg <- glm.fit(label_train ~ dat_train, family=binomial)
	return(fit_lg)
}