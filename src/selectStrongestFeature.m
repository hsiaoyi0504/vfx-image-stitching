function [featureMapOut] = selectStrongestFeature(featureMapIn,R,num)
	index = find(featureMapIn==1);
	r = R(index);
	[sorted_r order] = sort(r);
	sorted_index = index(order);
	featureMapOut = zeros(size(featureMapIn));
	featureMapOut(sorted_index(1:num)) = 1;
end