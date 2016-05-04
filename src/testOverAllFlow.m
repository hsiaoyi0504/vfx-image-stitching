close all
clear
clc
I = imread('../data/csie/IMG_8709.JPG');
I = im2double(I);
I = cylindricalProjection(I,1736.75);
imshow(I);
I = I*255;
[cornerMap,R] = harrisCorner(I);
[cornerMap] = selectStrongestFeature(cornerMap,R,100);
figure;
imshow(cornerMap);
[features,featuresRow,featuresCol] = featureDescription(I,cornerMap);
