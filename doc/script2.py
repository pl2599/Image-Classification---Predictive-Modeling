import os
import cv2
indir = '/Users/admin/Desktop/Columbia/Spring 2018/Applied DS/Pet Images and Extracted Features - Project 2/Practice image set 500'
for root, dirs, filenames in os.walk(indir):
    for f in filenames:
        img = cv2.imread(os.path.join(root, f))