close all;
clear('all');
clc
I = imread('../data/csie/IMG_8710.JPG');
I = im2double(I);
I2 = cylindricalProjection(I,1736.75);