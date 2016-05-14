function [goodM1,goodM2, goodFeaturesMatchRow1, goodFeaturesMatchRow2, goodFeaturesMatchCol1, goodFeaturesMatchCol2] = randsak(featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2,N,K)
    total = size(featuresMatchRow1,2);
    goodFeaturesMatchRow1 = [];
    goodFeaturesMatchRow2 = [];
    goodFeaturesMatchCol1 = [];
    goodFeaturesMatchCol2 = [];
    goodInlier = -1;
    goodM1 = 0;
    goodM2 = 0;
    rng(1)   
    for k = 1:K     
        randPerm = randperm(total);
        trainFeaturesMatchRow1 = featuresMatchRow1(randPerm(1:N));
        trainFeaturesMatchRow2 = featuresMatchRow2(randPerm(1:N));
        trainFeaturesMatchCol1 = featuresMatchCol1(randPerm(1:N));
        trainFeaturesMatchCol2 = featuresMatchCol2(randPerm(1:N));
        testFeaturesMatchRow1 = featuresMatchRow1(randPerm(N+1:total));
        testFeaturesMatchRow2 = featuresMatchRow2(randPerm(N+1:total));
        testFeaturesMatchCol1 = featuresMatchCol1(randPerm(N+1:total));
        testFeaturesMatchCol2 = featuresMatchCol2(randPerm(N+1:total));
        [m1,m2] = translationTransform(trainFeaturesMatchRow1,trainFeaturesMatchRow2,trainFeaturesMatchCol1,trainFeaturesMatchCol2);
        inlier = 0;
        for i = N+1:total
            ri = randPerm(i);
            error = calculateError(featuresMatchRow1(ri),featuresMatchRow2(ri),featuresMatchCol1(ri),featuresMatchCol2(ri),m1,m2);
            if(error < 2)
                inlier = inlier + 1;
            end
        if(inlier > goodInlier || goodInlier == -1)
            goodInlier = inlier;
            goodFeaturesMatchRow1 = trainFeaturesMatchRow1;
            goodFeaturesMatchRow2 = trainFeaturesMatchRow2;
            goodFeaturesMatchCol1 = trainFeaturesMatchCol1;
            goodFeaturesMatchCol2 = trainFeaturesMatchCol2;
            goodM1 = m1;
            goodM2 = m2;
        end
    end
end