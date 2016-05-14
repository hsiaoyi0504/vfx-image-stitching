function error = calculateError(featuresMatchRow1,featuresMatchRow2,featuresMatchCol1,featuresMatchCol2,m1,m2)
    error = 0;
    tmp = featuresMatchRow1- featuresMatchRow2 - m1;
    tmp = tmp.*tmp;
    error = error + sum(tmp);   
    tmp = featuresMatchCol1 - featuresMatchCol2 - m2;
    tmp = tmp.*tmp;
    error = error + sum(tmp);         
end