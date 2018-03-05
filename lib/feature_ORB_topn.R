############### Description: turns ORB keypoints and descriptors from many images into a single matrix where nrows=number of images, ncols = length of 10 random sequentially concatentated 128-dim keypoint descriptors (for each image.)

## 

############### Inputs:
# "img_dir" = must NOT end with a "/"


# "set_name" = default = ""

# "data_name" =       default ="pets"

# "export" =     default = TRUE

# "nfeatures" = number of random keypoint descriptors to use image. 
# default = 10

############## Outputs:
# "dat" = an .RData file of ORB features for all images in input directory. 
# nrow = number of images in input directory. ncol = 128*nfeatures

# "feature_ORB_random_data_name_set_name.RData" = file containing the "dat" 
# data object



###################################

#img_dir <-  "/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/Pet Images and Extracted Features - Project 2/python pets"

feature_ORB_topn <- function(img_dir, set_name = "", data_name = "pets", export=T, nfeatures = 5) {
  
  library(RcppCNPy)
  
  
  
  n_files <- length(list.files(img_dir))-1  
  
  dat <- matrix(NA, nrow = n_files, ncol = 32*nfeatures)
  #dat <- list()
  
  for (i in 1:n_files) {
    #retest <- npyLoad("/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/GitHub/project-2-predictive-modelling-group-5/doc/Printing 2.npy")
    
    # loads i (5,32) top ***5 key pointdescriptors
    # image keypoints
    array <- unlist(npyLoad(paste(img_dir,'/', 'pet', i, '.npy', sep = '')))
    
    # turn matrix "array" into a single vector made up of the sequentially 
    # concatonated rows of "subset". assign the new vector to the 
    #ith element of "dat" list
    array <- as.vector(t(array))
    #array <- as.numeric(array)
    
    # I have a problem where a lot( maybe 10%) of the matricies are missing a few values...
    if (length(array) == 1920) {
      dat[i,]  <- array
    } else {
      dat[i,]  <- dat[1,]
    }
  }
  
  ### output constructed features
  if(export){
    save(dat, file = paste0("../output/feature_ORB_random", data_name, "_", set_name, ".RData"))
  } 
  #output "dat" as matrix
  dat
}
