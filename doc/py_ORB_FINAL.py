#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar  5 01:42:18 2018

@author: admin
"""

####### there seems not to be a 501st image despite the length of gray_images..

#Also, I fear the images are imported out of order because the gray_images dimensions 
#don't match the order of dimensions in the actual source directory

import cv2
from os import listdir
from os.path import isfile, join
import numpy
import re 
import glob

mypath='/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/Pet Images and Extracted Features - Project 2/Practice image set 500'

onlyfiles = [] 
for f in listdir(mypath):
    onlyfiles.append(join(mypath,f)) 

def sorted_nicely( l ): 
    """ Sort the given iterable in the way that humans expect.""" 
    convert = lambda text: int(text) if text.isdigit() else text 
    alphanum_key = lambda key: [ convert(c) for c in re.split('([0-9]+)', key) ] 
    return sorted(l, key = alphanum_key)

onlyfiles = sorted_nicely(onlyfiles)


gray_images = numpy.empty(len(onlyfiles), dtype=object)
for n in range(0, len(onlyfiles)):
  gray_images[n] = cv2.imread( join(mypath,onlyfiles[n]), 0)


orb = cv2.ORB_create(nfeatures = 30)

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
    keypoint, descriptor = orb.detectAndCompute(gray_images[n], None)
    py_keypoints.append(keypoint)
    py_descriptors.append(descriptor)
    
print(py_descriptors)

#numpy.save('testagain',py_descriptors[5])




#a = iter(list(range(10)))
#for i in a:
#    numpy.save('Printing {}'.format(i), py_descriptors[i] )
#    next(a)


#This WORKS!!!!!!
#a = iter(list(range(len(py_descriptors))))
#for i in a:
#    numpy.save('pet{}'.format(i), py_descriptors[i] )
#don't use this
#    next(a)


savepath = "/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/Pet Images and Extracted Features - Project 2/python pets"

a = iter(list(range(len(py_descriptors))))
for i in a:
    numpy.save(join(savepath, 'pet{}'.format(i)), py_descriptors[i] )



#len(py_descriptors)
#######################

