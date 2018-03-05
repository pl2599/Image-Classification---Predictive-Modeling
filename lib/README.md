# Project 2: 
### Code lib Folder

The lib directory contains various files with function definitions that are called in `main.Rmd` (but only function definitions - no code that actually runs), such as `feature.R`, `train.R`, `cross_validation.R`, `test.R`. It also saves a few features we explored and tested in the process.


### Convolutional Neral Networks Model 

Convolution is a mathematical operation that’s used in single processing to filter signals, find patterns in signals.    
In cnn, we used `tf.nn.conv2d` to create 3 convolutional layers (one is gray)  
![image](../figs/cnn_image_1.png)  

For prediction and optimization, we use `session.run()` to calculate accuracy. Function `print_accuracy` is a function for printing the classification accuracy on the test set.  

