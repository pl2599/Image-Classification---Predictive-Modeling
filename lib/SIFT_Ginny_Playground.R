#############################################################
### Construct visual features for training/testing images ###
#############################################################

### Authors: Ginny Gao
### Project 2
### ADS Spring 2018

#SIFT features with max, min sum per image


feature <- function(img_dir, set_name, data_name = "data", export = T){

train_features_dir <- paste(experiment_dir, "train-features/", sep = "")

n_files <- length(list.files(img_dir))

load(paste(train_features_dir, 'pet', 1, '.jpg.sift.Rdata', sep = ''))
dat <- rbind(subset(features, rowSums(features) == max(rowSums(features))), 
             subset(features, rowSums(features) == min(rowSums(features))))

for (i in 2 : n_files) {
    	load(paste(train_features_dir, 'pet', i, '.jpg.sift.Rdata', sep = ''))
    	dat_i[1 : 2, ] <- rbind(subset(features, rowSums(features) == max(rowSums(features))),
    	                        subset(features, rowSums(features) == min(rowSums(features))))
    	dat <- rbind(dat, dat_i[1 : 2, ])
	}


### output constructed features
if(export){
    save(dat, file = paste0("../output/feature_", data_name, "_", set_name, ".RData"))
    }
return(dat)
}



