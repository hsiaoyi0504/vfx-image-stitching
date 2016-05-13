close all
clear
clc

I = imread('../data/csie/IMG_8709.JPG');
I = im2double(I);
[I,rangeY,rangeX]= cylindricalProjection(I,1732.68);

% I = imread('../data/csie/IMG_8710.JPG');
% I = im2double(I);
% [I,rangeY,rangeX]= cylindricalProjection(I,1736.75);

imshow(I), hold on;
I = I*255;
[cornerMap,R] = harrisCorner(I);
[cornerMap] = selectStrongestFeature(cornerMap,R,200);
cornerMap(rangeY:end,:) = 0;
cornerMap(:,rangeX:end) = 0;
[row,col] = find(cornerMap==1);
plot(col,row,'ro','MarkerSize',3);

[features,featuresRow,featuresCol] = featureDescription(I,cornerMap);
