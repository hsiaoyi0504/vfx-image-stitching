function [features,featuresRow,featuresCol] = featureDescription(imgIn,featureMap)
	[row,col] = find(featureMap==1);
	features = [];
	featuresRow = [];
	featuresCol = [];
	for i = 1:size(row,1)
		if(row(i)-2 > 0 && row(i)+2 < size(imgIn,1) && col(i)-2 > 0 && col(i)+2 < size(imgIn,2))
			features = [ features; reshape(imgIn(row(i)-2:row(i)+2,col(i)-2:col(i)+2),1,[]);];
			featuresRow = [featuresRow; row(i)];
			featuresCol = [featuresCol; col(i)];
		end
	end
end