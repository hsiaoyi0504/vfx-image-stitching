function [featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2] = featureMatching(features1,features2,featuresRow1,featuresRow2,featuresCol1,featuresCol2)
    featuresMatchRow1 = [];
    featuresMatchRow2 = [];
    featuresMatchCol1 = [];
    featuresMatchCol2 = [];
    %kdTree = KDTreeSearcher(features1)
    ehSearcher1 = ExhaustiveSearcher(features1);
    [idx1,distance1] = knnsearch(ehSearcher1,features2,'K',2,'Distance','euclidean');
    ehSearcher2 = ExhaustiveSearcher(features2);
    [idx2,distance2] = knnsearch(ehSearcher2,features1,'K',2,'Distance','euclidean');
    for i = 1:size(distance1,1)
        % if distance1(i,1)/distance1(i,2) < 2
        if(idx2(idx1(i,1),1) == i || idx2(idx1(i,1),2) == i )
            featuresMatchRow1 = [featuresMatchRow1,featuresRow1(idx1(i,1))];
            featuresMatchRow2 = [featuresMatchRow2,featuresRow2(i)];
            featuresMatchCol1 = [featuresMatchCol1,featuresCol1(idx1(i,1))];
            featuresMatchCol2 = [featuresMatchCol2,featuresCol2(i)];
        end
    end