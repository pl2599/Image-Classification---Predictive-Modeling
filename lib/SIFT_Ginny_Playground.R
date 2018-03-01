#SIFT max, min

dat <- matrix(NA, 4, 128)
load(paste(train_features_dir, 'pet', 1, '.jpg.sift.Rdata', sep = ''))
dat1 <- rbind(subset(features, rowSums(features) == max(rowSums(features))), 
		#subset(features, rowSums(features) == median(rowSums(features))),
    	subset(features, rowSums(features) == min(rowSums(features))))
for(i in 2 : 2){
    load(paste(train_features_dir, 'pet', i, '.jpg.sift.Rdata', sep = ''))
    dat[1:2,] <- rbind(subset(features, rowSums(features) == max(rowSums(features))),
    	#subset(features, rowSums(features) == median(rowSums(features))),
    	subset(features, rowSums(features) == min(rowSums(features))))
	dat <- rbind(dat1, dat[1:2,])
	}















