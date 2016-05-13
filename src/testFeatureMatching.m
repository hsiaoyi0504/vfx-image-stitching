close all
clear
clc
I1 = imread('../data/csie/IMG_8709.JPG');
I1 = im2double(I1);
[I1,rangeY,rangeX]= cylindricalProjection(I1,1736.75);
%imshow(I1);
im1 = I1;
I1 = I1*255;
[cornerMap,R,Gx,Gy] = harrisCorner(I1);
[cornerMap1] = selectStrongestFeature(cornerMap,R,100);
%figure;
%imshow(cornerMap1);
%[features1,featuresRow1,featuresCol1] = featureDescriptionSIFT(I1,cornerMap1,Gx,Gy);
[features1,featuresRow1,featuresCol1] = featureDescription(I1,cornerMap1);
%fpds = SIFT(I1,cornerMap1);
%featuresRow1 = fpds.fpX;
%featuresCol1 = fpds.fpY;
%features1 = fpds.fpd;
I2 = imread('../data/csie/IMG_8710.JPG');
I2 = im2double(I2);
[I2,rangeY,rangeX]= cylindricalProjection(I2,1736.75);
%figure;
%imshow(I2);
im2 = I2;
I2 = I2*255;
[cornerMap2,R2] = harrisCorner(I2);
[cornerMap2] = selectStrongestFeature(cornerMap2,R2,100);
%figure;
%imshow(cornerMap2);
%figure;
%imshow(I),hold on;
%[features2,featuresRow2,featuresCol2] = featureDescriptionSIFT(I2,cornerMap2,Gx,Gy);
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
[m1,m2] = translationTransform(featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2);
stichIm = zeros(size(im));
imXRange = size(im,2);
imYRange = size(im,1);
im1XRange = size(im1,2);
im1YRange = size(im1,1);
im2XRange = size(im2,2);
im2YRange = size(im2,1);

m1
m2

%stichIm(1:im1XRange,1:im1YRange,:) = im1(1:im1XRange,1:im1YRange,:);
%stichIm(im1XRange+1+m1:im1XRange+im2XRange+m1) = im2(1:im1)

for x = 1:imXRange
    for y = 1:imYRange
        if(x<=im1XRange && y<=im1YRange)
        stichIm(y,x,:) = im1(y,x,:);
        end
        if(x-m2-im1XRange<=im2XRange && x-m2-im2XRange>0 && y-m1<=im2YRange && y-m1>0)
            stichIm(y,x,:) = im2(y-m1,x-im1XRange - m2,:);
        end
    end
end

figure;
imshow(stichIm);