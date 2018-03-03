#############################################################
### Construct visual features for training/testing images ###
#############################################################

### Authors: Yuting Ma/Tian Zheng
### Project 3
### ADS Spring 2017

feature <- function(img_dir, set_name, data_name="data", export=T){
  
  ### Construct process features for training/testing images
  ### Sample simple feature: Extract row average raw pixel values as features
  
  ### Input: a directory that contains images ready for processing
  ### Output: an .RData file contains processed features for the images
  
  ### load libraries
  library("EBImage")
  
  n_files <- length(list.files(img_dir))
  
  ### determine img dimensions
  img0 <-  readImage(paste0(img_dir, "img", "_", data_name, "_", set_name, "_", 1, ".jpg"))
  mat1 <- as.matrix(img0)
  n_r  <- nrow(img0)
  
  ### store vectorized pixel values of images
  dat <- matrix(NA, n_files, n_r) 
  for(i in 1:n_files){
    img     <- readImage(paste0(img_dir,  "img", "_", data_name, "_", set_name, "_", i, ".jpg"))
    dat[i,] <- rowMeans(img)
  }
  
  ### output constructed features
  if(export){
    save(dat, file = paste0("../output/feature_", data_name, "_", set_name, ".RData"))
  }
  return(dat)
}


feature_rgb <- function(img_dir, set_name, data_name="pets", export=T)
{
  library("EBImage")
  file.sources = list.files(img_dir, pattern="*.jpg")
  
  
  #Create dimensions of the matrix
  img0 <- readImage(paste0(img_dir, file.sources[1]))
  img0 <- resize(img0, 128, 128)
  n_c <- length(img0)
  
  rgb_feature <- matrix(NA, length(file.sources), n_c) 

  for(i in 1:length(file.sources))
  {
    img <- readJPEG(paste0(img_dir, file.sources[i]))
    img <- resize(img, 128, 128)
    rgb_feature[i,] <- c(img)
  }
    
  if(export)
  {
    save(rgb_feature, file = paste0("../output/rgb_feature_", data_name, "_", set_name, ".RData"))
  }
  
  return(rgb_feature)
}

feature_pca <- function(data, feature_name, data_name = "pets", set_name, n, cen = FALSE, sca = FALSE, export = T)
{
  pca <- prcomp(data, center = cen, scale = sca)
  
  if(export)
  {
    save(pca$x[,1:n], file = paste0("../output/pca_", feature_name, "feature_", data_name, "_", set_name, ".RData"))
  }
  
  return(pca$x[,1:n])
}