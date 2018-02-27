#############################################################
### Construct visual features for training/testing images ###
#############################################################

### Authors: Ginny Gao
### Project 2
### ADS Spring 2018

#SIFT feature, first try: select row with max keypoint feature sum

feature <- function(img_dir, set_name, data_name="data", export=T){

train_features_dir <- paste(experiment_dir, "train-features/", sep = "")

n_files <- length(list.files(img_dir))

dat <- matrix(NA, n_files, 128)
for(i in 1 : n_files){
    load(paste(train_features_dir, 'pet', i, '.jpg.sift.Rdata', sep = ''))
    dat[i,] <- subset(features, rowSums(features) == max(rowSums(features)))
    }

### output constructed features
if(export){
    save(dat, file = paste0("../output/feature_", data_name, "_", set_name, ".RData"))
    }
return(dat)
}

