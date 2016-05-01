close all
clear
clc
I = checkerboard;
[cornerMap,R]= harrisCorner(I);
imshow(cornerMap);
I = imread('../data/csie/IMG_8709.JPG');
I = im2double(I);
[cornerMap,R]= harrisCorner(I);
figure;
imshow(cornerMap);