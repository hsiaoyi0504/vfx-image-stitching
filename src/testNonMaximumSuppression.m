close all
clear
clc
I = imread('../data/csie/IMG_8709.JPG');
I = im2double(I);
[cornerMap,R] = harrisCorner(I);
[cornerMap] = nonMaximumSuppression(cornerMap,R,50);