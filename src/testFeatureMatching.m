close all
clear
clc
I1 = imread('../data/csie/IMG_8709.JPG');
I1 = im2double(I1);
[I1,rangeY,rangeX]= cylindricalProjection(I1,1732.68);



im1 = I1;
I1 = I1*255;
[cornerMap,R,Gx,Gy] = harrisCorner(I1(:,round(rangeX/2):end));
[cornerMap1] = selectStrongestFeature(cornerMap,R,300);
cornerMap1 = [zeros(size(I1,1),round(rangeX/2)-1) cornerMap1];

cornerMap1(rangeY:end,:) = 0;
cornerMap1(:,rangeX:end) = 0;
cornerMap1(:,1:round(rangeX/2)) = 0;
% [features1,featuresRow1,featuresCol1] = featureDescriptionSIFT(I1,cornerMap1,Gx,Gy);
[features1,featuresRow1,featuresCol1] = featureDescription(I1,cornerMap1);
%fpds = SIFT(I1,cornerMap1);
%featuresRow1 = fpds.fpX;
%featuresCol1 = fpds.fpY;
%features1 = fpds.fpd;
I2 = imread('../data/csie/IMG_8710.JPG');
I2 = im2double(I2);
[I2,rangeY,rangeX]= cylindricalProjection(I2,1736.75);

im2 = I2;
I2 = I2*255;
[cornerMap2,R2] = harrisCorner(I2(:,1:round(rangeX/2)));
[cornerMap2] = selectStrongestFeature(cornerMap2,R2,350);
cornerMap2 = [cornerMap2 zeros(size(I2,1),size(I2,2)-round(rangeX/2))];
cornerMap2(rangeY:end,:) = 0;
cornerMap2(:,rangeX:end) = 0;
cornerMap2(:,round(rangeX/2):end) = 0;
% [features2,featuresRow2,featuresCol2] = featureDescriptionSIFT(I2,cornerMap2,Gx,Gy);
[features2,featuresRow2,featuresCol2] = featureDescription(I2,cornerMap2);

%fpds = SIFT(I2,cornerMap2);
%featuresRow2 = fpds.fpX;
%featuresCol2 = fpds.fpY;
%features2 = fpds.fpd;
[featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2] = featureMatching(features1,features2,featuresRow1,featuresRow2,featuresCol1,featuresCol2);
im = [im1,im2];
featuresMatchCol2 = featuresMatchCol2+size(I1,2);
figure;
imshow(im), hold on;
[row,col] = find(cornerMap1==1);
plot(col,row,'ro','MarkerSize',3);
[row,col] = find(cornerMap2==1);
col = col + size(I1,2);
plot(col,row,'ro','MarkerSize',3);
%plot(featuresMatchCol1,featuresMatchRow1,'ro','MarkerSize',3);
%plot(featuresMatchCol2,featuresMatchRow2,'ro','MarkerSize',3);
%plot([1,1],[100,1],'Color','r','LineWidth',2);
x = [reshape(featuresMatchCol1,[],1),reshape(featuresMatchCol2,[],1)];
y = [reshape(featuresMatchRow1,[],1),reshape(featuresMatchRow2,[],1)];
x = [featuresMatchCol1;featuresMatchCol2];
y = [featuresMatchRow1;featuresMatchRow2];
plot(x,y,'Color','r','LineWidth',1);
%plot([featuresMatchCol1(1),featuresMatchCol2(1)],[featuresMatchRow1(1),featuresMatchRow2(1)],'Color','r','LineWidth',2);

