close all
clear
clc
I = checkerboard;
% I = imread('../data/csie/IMG_8709.JPG');
% I = im2double(I);
[cornerMap,Gx,Gy,R]= harrisCorner(I);
imshow(cornerMap);