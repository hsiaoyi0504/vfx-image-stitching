function [m1,m2] = translationTransform(featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2)
    n = size(featuresMatchCol1,1);
    xSum = 0;
    ySum = 0;
    for i = 1:n
        ySum = ySum + featuresMatchRow1(i) - featuresMatchRow2(i);        
        xSum = xSum + featuresMatchCol1(i) - featuresMatchCol2(i);
    m1 = ySum/n;
    m2 = xSum/n;
    %transform = eye(3);
    %transform(1,3) = m1;
    %transform(2,3) = m2;        
end