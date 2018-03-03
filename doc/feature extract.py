#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar  3 12:07:01 2018

@author: admin
"""

import cv2
from os import listdir
from os.path import isfile, join
import numpy

mypath='/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/Pet Images and Extracted Features - Project 2/Practice image set 500'
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
images = numpy.empty(len(onlyfiles), dtype=object)
for n in range(0, len(onlyfiles)):
  images[n] = cv2.imread( join(mypath,onlyfiles[n]) )

gray_img = numpy.empty(len(onlyfiles), dtype=object)
for n in range(0, len(onlyfiles)):
    gray_img[n] = cv2.cvtColor(images[n], cv2.COLOR_BGR2GRAY) 

orb = cv2.ORB_create(nfeatures = 5)
keypoints[n], py_descriptor[n] = orb.detectAndCompute(gray_img[n], None)
print(py_descriptors)



------------------
####With direct gray input
#https://stackoverflow.com/questions/33369832/read-multiple-images-on-a-folder-in-opencv-python
#https://stackoverflow.com/questions/30506126/open-cv-error-215-scn-3-scn-4-in-function-cvtcolor


import cv2
from os import listdir
from os.path import isfile, join
import numpy

mypath='/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/Pet Images and Extracted Features - Project 2/Practice image set 500'
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]

gray_images = numpy.empty(len(onlyfiles), dtype=object)
for n in range(0, len(onlyfiles)):
  gray_images[n] = cv2.imread( join(mypath,onlyfiles[n]), 0)


orb = cv2.ORB_create(nfeatures = 5)

##maybe make ky and desc lists?
#py_keypoints = numpy.empty(shape =(5*len(onlyfiles), 32), dtype=object)
#py_descriptors = numpy.empty(shape =(5*len(onlyfiles), 32), dtype=object)
py_keypoints = []
py_descriptors = []

#What exactly is structure of gray_images[n] that 
#is being put in detect/compute? is it the right structure for that function?
#make sure I am creating adescriptor array which is the right size to take the 
#output of orb.detectAndCompute() with input of gray_images[n]
# took out start range at 0
for n in range(len(gray_images)):
    # take out the [n] for the ky and desc objs?
    py_keypoints[n], py_descriptors[n] = orb.detectAndCompute(gray_images[n], None)
    #py_keypoints, py_descriptors = orb.detectAndCompute(gray_images[n], None)
print(py_descriptors)

________________________________
######## Try the stolen strategy


import cv2
from os import listdir
from os.path import isfile, join
import numpy

mypath='/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/Pet Images and Extracted Features - Project 2/Practice image set 500'
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
img_paths = numpy.empty(len(onlyfiles), dtype=object)
for n in range(0, len(onlyfiles)):
  img_paths[n] = join(mypath,onlyfiles[n]) 


gray_images = cv2.imread(img_paths, 0)

orb = cv2.ORB_create(nfeatures = 5)

py_keypoints, py_descriptors = orb.detectAndCompute(gray_images, None)

output = []
 
# loop over the keypoints and descriptors
for (py_keypoints, py_descriptors) in zip(py_keypoints, py_descriptors):
    # update the output list as a 2-tuple of the keypoint (x, y)-coordinates
	# and the feature vector
	output.append((py_descriptors.tolist(), vec.tolist()))

print(output)



######isues
#dtype=object Why?? " you could use the dtype object, which enables the array to hold arbitrary Python objects"