function [features,featuresRow,featuresCol] = featureDescription(imgIn,featureMap)
	[row,col] = find(featureMap==1);
	features = [];
	featuresRow = [];
	featuresCol = [];
	for i = 1:size(row,1)
		if(row(i)-1 > 0 && row(i)+1 < size(imgIn,1) && col(i)-1 > 0 && col(i)+1 < size(imgIn,2))
			features = [ features; reshape(imgIn(row(i)-1:row(i)+1,col(i)-1:col(i)+1),1,[]);];
			featuresRow = [featuresRow; row(i)];
			featuresCol = [featuresCol; col(i)];
		end
	end
end