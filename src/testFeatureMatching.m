close all
clear
clc

totalRangeX = 0;
m1=0
m2=0
featureNum= [100,150;100,50;200,200;200,200];
focalLenth = [1732.68,1736.75,1735.39,1729.41];
I1 = imread('../data/csie/IMG_8709.JPG');
I2 = []
I1 = im2double(I1);
[I1,rangeY,rangeX]= cylindricalProjection(I1,focalLenth(1));
totalRangeX = totalRangeX+rangeX;
im1 = I1;
stichIm0 = im1;
I1 = I1*255;

[cornerMap1,R,Gx,Gy] = harrisCorner(I1(:,round(rangeX/2):end));
[cornerMap1] = selectStrongestFeature(cornerMap1,R,featureNum(1,1));
cornerMap1 = [zeros(size(I1,1),round(rangeX/2)-1) cornerMap1];
cornerMap1(rangeY:end,:) = 0;
cornerMap1(:,rangeX:end) = 0;
cornerMap1(:,1:round(rangeX/2)) = 0;
%[features1,featuresRow1,featuresCol1] = featureDescription(I1,cornerMap1);
[features1,featuresRow1,featuresCol1] = featureDescriptionSIFT(I1,cornerMap1,Gx,Gy);
for p=1:3
    if p == 1
        I2 = imread('../data/csie/IMG_8710.JPG');
    end
    if p == 2
        I2 = imread('../data/csie/IMG_8713.JPG');    
    end
    if p == 3
        I2 = imread('../data/csie/IMG_8714.JPG');    
    end
    I2 = im2double(I2);
    [I2,rangeY,rangeX]= cylindricalProjection(I2,focalLenth(p+1));
    totalRangeX = totalRangeX+rangeX;
    im2 = I2;
    I2 = I2*255;
    [cornerMap2,R2,Gx,Gy] = harrisCorner(I2(:,1:round(rangeX/2)));
    [cornerMap2] = selectStrongestFeature(cornerMap2,R2,featureNum(p,2));
    cornerMap2 = [cornerMap2 zeros(size(I2,1),size(I2,2)-round(rangeX/2))];
    cornerMap2(rangeY:end,:) = 0;
    cornerMap2(:,rangeX:end) = 0;
    cornerMap2(:,round(rangeX/2):end) = 0;
    %[features2,featuresRow2,featuresCol2] = featureDescription(I2,cornerMap2);
    [features2,featuresRow2,featuresCol2] = featureDescriptionSIFT(I2,cornerMap2,Gx,Gy);
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
    m1 = m1+tmp_m1;
    m2 = m2+tmp_m2;
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
    y = max(m1+1,0)-(m1+1)+1;
    x = max(m2+1,0)-(m2+1)+1;
    stichIm(m1+1+y:im2YRange+m1,m2+1+x:im2XRange+m2,:) = im2(1+y:im2YRange,1+x:im2XRange,:);
    %{
    for x = 1:imXRange
        for y = 1:imYRange
            if(x<=im1XRange && y<=im1YRange)
                stichIm(y,x,:) = stichIm0(y,x,:);
            end
            if(x-m2-im1XRange<=im2XRange && x-m2-im1XRange>0 && y-m1<=im2YRange && y-m1>0)
                stichIm(y,x,:) = im2(y-m1,x-im1XRange - m2,:);
            end

        end
    end
    %}
    figure;
    imshow(stichIm);

    I1 = I2;
    features1=features2;
    featuresRow1=featuresRow2;
    featuresCol1=featuresCol2;
    im1 = im2;
    stichIm0 = stichIm;

    [cornerMap,R,Gx,Gy] = harrisCorner(I1(:,round(rangeX/2):end));
    [cornerMap1] = selectStrongestFeature(cornerMap,R,featureNum(p+1,1));
    cornerMap1 = [zeros(size(I1,1),round(rangeX/2)-1) cornerMap1];
    cornerMap1(rangeY:end,:) = 0;
    cornerMap1(:,rangeX:end) = 0;
    cornerMap1(:,1:round(rangeX/2)) = 0;
    totalRangeX = totalRangeX+rangeX;
    [features1,featuresRow1,featuresCol1] = featureDescription(I1,cornerMap1);
end
