close all
clear
clc
%% this test hasn't finished
I = imread('../data/csie/IMG_8709.JPG');
I = im2double(I);
[cornerMap,R] = harrisCorner(I);
[cornerMap] = nonMaximumSuppression(cornerMap,R,50);