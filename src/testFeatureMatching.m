close all
clear
clc

totalRangeX = 0;
m1 = 0;
m2 = 0;
featureNum= [150,150; 200,150; 200,200; 100,50; 50,50; 150,150; 200,200; 200,200; 200,200;];
focalLenth = [1732.68,1736.75,1735.39,1729.41,1728.58,1726.44,1724.53,1724.56,1724.25];
imageList = [
	'../data/csie/IMG_8709.JPG';
	'../data/csie/IMG_8710.JPG';
	'../data/csie/IMG_8713.JPG';
	'../data/csie/IMG_8714.JPG';
	'../data/csie/IMG_8715.JPG';
	'../data/csie/IMG_8716.JPG';
	'../data/csie/IMG_8717.JPG';
	'../data/csie/IMG_8718.JPG';
	'../data/csie/IMG_8719.JPG';
];
I1 = imread(imageList(1,:));
I2 = [];
I1 = im2double(I1);
[I1,rangeY1,rangeX1]= cylindricalProjection(I1,focalLenth(1));
totalRangeX = totalRangeX+rangeX1;
im1 = I1;
stichIm0 = im1;
I1 = I1*255;
max_m1 = 0;
min_m1 = size(I1,1);
[cornerMap1,R,Gx,Gy] = harrisCorner(I1(:,round(rangeX1/2):end));
[cornerMap1] = selectStrongestFeature(cornerMap1,R,featureNum(1,1));
cornerMap1 = [zeros(size(I1,1),round(rangeX1/2)-1) cornerMap1];
cornerMap1(rangeY1:end,:) = 0;
cornerMap1(:,rangeX1:end) = 0;
cornerMap1(:,1:round(rangeX1/2)) = 0;
[features1,featuresRow1,featuresCol1] = featureDescription(I1,cornerMap1);
% [features1,featuresRow1,featuresCol1] = featureDescriptionSIFT(I1,cornerMap1,Gx,Gy);
for p=1:8
    I2 = imread(imageList(p+1,:));
    I2 = im2double(I2);
    [I2,rangeY2,rangeX2]= cylindricalProjection(I2,focalLenth(p+1));
    totalRangeX = totalRangeX+rangeX2;
    im2 = I2;
    I2 = I2*255;
    [cornerMap2,R2,Gx,Gy] = harrisCorner(I2(:,1:round(rangeX2/2)));
    [cornerMap2] = selectStrongestFeature(cornerMap2,R2,featureNum(p,2));
    cornerMap2 = [cornerMap2 zeros(size(I2,1),size(I2,2)-round(rangeX2/2))];
    cornerMap2(rangeY2:end,:) = 0;
    cornerMap2(:,rangeX2:end) = 0;
    cornerMap2(:,round(rangeX2/2):end) = 0;
    [features2,featuresRow2,featuresCol2] = featureDescription(I2,cornerMap2);
    % [features2,featuresRow2,featuresCol2] = featureDescriptionSIFT(I2,cornerMap2,Gx,Gy);
    [featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2] = featureMatching(features1,features2,featuresRow1,featuresRow2,featuresCol1,featuresCol2);
    im12 = [im1,im2];
    figure;
    imshow(im12), hold on;
    [row,col] = find(cornerMap1==1);
    plot(col,row,'ro','MarkerSize',3);
    [row,col] = find(cornerMap2==1);
    col = col + size(I1,2);
    plot(col,row,'ro','MarkerSize',3);
    x = [featuresMatchCol1;featuresMatchCol2+size(I1,2)];
    y = [featuresMatchRow1;featuresMatchRow2];
    plot(x,y,'Color','r','LineWidth',1);

    tmp_m1 = m1;
    tmp_m2 = m2;
    %[m1,m2] = translationTransform(featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2);
    [m1,m2, goodFeaturesMatchRow1, goodFeaturesMatchRow2, goodFeaturesMatchCol1, goodFeaturesMatchCol2] = randsak(featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2,3,5000);
	M1 = m1;
	M2 = m2;   
    m1 = m1+tmp_m1;
    m2 = m2+tmp_m2;
    max_m1 = max(m1,max_m1);
    min_m1 = min(m1+rangeY2,min_m1);
    im2Fit = zeros(size(stichIm0));
    im2Fit(1:size(im2,1),1:size(im2,2),:) = im2(:,:,:);
    stichIm = zeros(size([stichIm0,im2Fit]));
    imXRange = size(stichIm,2);
    imYRange = size(stichIm,1);
    im1XRange = size(stichIm0,2);
    im1YRange = size(stichIm0,1);
    im2XRange = size(im2,2);
    im2YRange = size(im2,1);
    
    stichIm(1:im1YRange,1:im1XRange,:) = stichIm0(1:im1YRange,1:im1XRange,:);
    stichIm(max(m1+1,1):im2YRange+m1,max(m2+1,1):im2XRange+m2,:) = im2(max(1,1-m1):im2YRange,max(1,1-m2):im2XRange,:);

    % stichIm(max(m1+1,1):min(im1YRange-im2YRange+rangeY1,max(m1+1,1)+rangeY2-1),max(m2+1,1):min(im1XRange-im2XRange+rangeX1,max(m2+1,1)+rangeX2-1),:) =  ...
    % blending(im1(max(1,M1+1):min(M1+rangeY2,rangeY1),max(1,M2+1):min(M2+rangeX2,rangeX1),:),im2(max(1,1-M1):min(rangeY1-M1,rangeY2),max(1,1-M2):min(rangeX1-M2,rangeX2),:));
	% size(stichIm(max(m1+1,tmp_m1+1):min(tmp_m1+rangeY1,max(m1+1,tmp_m1+1)+rangeY2-1),max(m2+1,tmp_m2+1):min(tmp_m2+rangeX1,max(m2+1,tmp_m2+1)+rangeX2-1),:))
	% size(blending(im1(max(1,M1+1):min(M1+rangeY2,rangeY1),max(1,M2+1):min(M2+rangeX2,rangeX1),:),im2(max(1,1-M1):min(rangeY1-M1,rangeY2),max(1,1-M2):min(rangeX1-M2,rangeX2),:)))
	stichIm(max(m1+1,tmp_m1+1):min(tmp_m1+rangeY1,m1+1+rangeY2-1),max(m2+1,tmp_m2+1):min(tmp_m2+rangeX1,m2+1+rangeX2-1),:) =  ...
    blending(im1(max(1,M1+1):min(M1+rangeY2,rangeY1),max(1,M2+1):min(M2+rangeX2,rangeX1),:),im2(max(1,1-M1):min(rangeY1-M1,rangeY2),max(1,1-M2):min(rangeX1-M2,rangeX2),:));
    
    figure;
    imshow(im1(max(1,M1+1):min(M1+rangeY2,rangeY1),max(1,M2+1):min(M2+rangeX2,rangeX1),:));
    figure;
    imshow(im2(max(1,1-M1):min(rangeY1-M1,rangeY2),max(1,1-M2):min(rangeX1-M2,rangeX2),:));
    figure;
    imshow(blending(im1(max(1,M1+1):min(M1+rangeY2,rangeY1),max(1,M2+1):min(M2+rangeX2,rangeX1),:),im2(max(1,1-M1):min(rangeY1-M1,rangeY2),max(1,1-M2):min(rangeX1-M2,rangeX2),:)));

    figure;
    imshow(stichIm);

    I1 = I2;
    features1=features2;
    featuresRow1=featuresRow2;
    featuresCol1=featuresCol2;
    im1 = im2;
    stichIm0 = stichIm;

    rangeX1 = rangeX2;
    rangeY1 = rangeY2;
    [cornerMap,R,Gx,Gy] = harrisCorner(I1(:,round(rangeX1/2):end));
    [cornerMap1] = selectStrongestFeature(cornerMap,R,featureNum(p+1,1));
    cornerMap1 = [zeros(size(I1,1),round(rangeX2/2)-1) cornerMap1];
    cornerMap1(rangeY1:end,:) = 0;
    cornerMap1(:,rangeX1:end) = 0;
    cornerMap1(:,1:round(rangeX1/2)) = 0;
    totalRangeX = totalRangeX+rangeX1;
    [features1,featuresRow1,featuresCol1] = featureDescription(I1,cornerMap1);
end

% close all
finalRangeX = size(stichIm,2);
while(stichIm(:,finalRangeX,:)==0)
	finalRangeX = finalRangeX - 1;
end
stichIm = stichIm(max_m1:min_m1,1:finalRangeX,:);



figure;
imshow(stichIm);