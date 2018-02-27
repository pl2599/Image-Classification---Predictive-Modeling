feature <- function(img_dir){
	
	library(reticulate)
	cv2 <- reticulate::import('cv2')

	winSize <- tuple(64L,64L)
	blockSize <- tuple(16L,16L)
	blockStride <- tuple(8L,8L)
	cellSize <- tuple(8L,8L)
	nbins <- 9L	
	hog <- cv2$HOGDescriptor(winSize,blockSize,blockStride,cellSize,nbins)

	n_files <- length(list.files(img_dir))
	dat <- matrix(NA, n_files, 1764)

	for (i in 1:n_files){
		img <- readImage(paste0(img_dir, "pet", i, ".jpg"))
		img_resized <- cv2$resize(img, dsize=tuple(64L, 64L))
		hog_values <- hog$compute(np_array(img_resized * 255, dtype='uint8'))
		dat[i,] <- hog_values
	}
	return(dat)
}