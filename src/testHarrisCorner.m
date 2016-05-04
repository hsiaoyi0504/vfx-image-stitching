close all
clear
clc
% I = checkerboard;
% I = I*255;
% [cornerMap,R]= harrisCorner(I);
% imshow(cornerMap);
% figure;
% mesh(R);
I = imread('../data/csie/IMG_8709.JPG');
I = double(I);
[cornerMap,R]= harrisCorner(I);
figure;
imshow(cornerMap);
figure;
mesh(R);