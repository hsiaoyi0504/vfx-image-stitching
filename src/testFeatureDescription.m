close all
clear
clc
I = imread('../data/csie/IMG_8709.JPG');
I = im2double(I);
[cornerMap,R]= harrisCorner(I);
imshow(cornerMap);
[features,featuresRow,featuresCol] = featureDescription(I,cornerMap);