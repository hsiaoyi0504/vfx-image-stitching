function [featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2] = featureMatching(features1,features2,featuresRow1,featuresRow2,featuresCol1,featuresCol2)
    featuresMatchRow1 = [];
    featuresMatchRow2 = [];
    featuresMatchCol1 = [];
    featuresMatchCol2 = [];
    %kdTree = KDTreeSearcher(features1)
    ehSearcher = ExhaustiveSearcher(features1);
    [idx,distance] = knnsearch(ehSearcher,features2,'K',2,'Distance','cosine');
    for i = 1:size(distance,1)
        if distance(i,1)/distance(i,2) < 0.4
            featuresMatchRow1 = [featuresMatchRow1,featuresRow1(i)];
            featuresMatchRow2 = [featuresMatchRow2,featuresRow2(i)];
            featuresMatchCol1 = [featuresMatchCol1,featuresCol1(i)];
            featuresMatchCol2 = [featuresMatchCol2,featuresCol2(i)];
        end
    end