#### Description: turns SIFT keypoints and descriptors from many images into a single matrix where nrows=number of images, ncols = the sequentially concatentated k=10 center vectors from doing kmeans on the 128-dim keypoints from each image.

#### Inputs:
# "img_dir" = 

# "set_name" = default = ""

# "data_name" =       default ="pets"

# "export" =     default = TRUE

# "k" = number of centers to claculate with kmeans over the keypoints in each 
#image. default = 10

#### Outputs:
# "dat" = an .RData file of SIFT features for all images in input directory. 
# nrow = number of images in input directory. ncol = *****???

#img_dir <-  "/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/Pet Images and Extracted Features - Project 2/Practice SIFT Set 500/"


feature_SIFT <- function(img_dir, set_name = "", data_name = "pets", export=T, k = 10) {
  
  n_files <- length(list.files(img_dir))  
  
  dat <- list()
  
  for (i in 1:n_files) {
    load(paste(img_dir, 'pet', i, '.jpg.sift.Rdata', sep = ''))
    #set.seed(1234)
    
    # kmeans considers the matrix of keypoint descriptors for each image to be
    # n=number of key points observations in 128-dimensional space. kmeans 
    # summarized those n=number of key points observations into 10 means each a
    # location in 128-dim space.
    bof <- kmeans(features, k)
    
    # sequentially concatonated the 10 length =128 centers for the ith image;
    #assigned to the ith element of "dat" list
    dat[[i]] <- as.vector(t(bof$centers))
    # could take some time checking to NA values within the vectors of the list "dat", because I got 3 "did not converge in 10 iterations" warnings. But that is too much for now.
  }
  
  # combined the list elements into rows of a single matrix. 
  #dat <- do.call(rbind, dat)
  dat <- t(simplify2array(dat))
  
  ### output constructed features
  if(export){
    save(dat, file = paste0("../output/feature_SIFT_", data_name, "_", set_name, ".RData"))
  } 
  #output "dat" as matrix
  return(dat)
}

  


#####################################################
####Improvements?
# Look into the "bag of words" process for selecting keypoints per image

# different approach to selecting features: create function that selects 5
# random keypoint descriptor sets and concatenates them sequentially into 
# a single row. In which case one of the inputs would be: nkeypoints =  
# number of key points per image to deliver to output. default = 5




###########################


             
             