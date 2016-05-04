function [featureMapOut] = nonMaximumSuppression(featureMapIn,R,num)
	%% still under implement
	index = find(featureMapIn==1);
	r = R(index);
	[sorted_r order] = sort(r);
	sorted_index = index(order);
	featureMapOut = zeros(size(featureMapIn));
	counter = 0;
	[sorted_row,sorted_col] = ind2sub(size(featureMapIn),sorted_index);
	dist_max = size(featureMapIn,1)^2 + size(featureMapIn,2)^2 );
	while(counter<num)
		% dist = dist_max;
		% while(dist>0)
		% 	for i = 1:size(sorted_index)
		% 		if()
		% 			dist
		% 		end
		% 	end
		% 	dist = dist - 1;
		% end
	end
	% sorted_sub = ind2sub(sorted_index);
	% outMap = zeros(size(inMap));
	% size_count = 0;
	% while(size_count<num)
	% 	r = round(sqrt(size(outMap,1)^2+size(outMap,2)^2));

	% end
	% outMap = sorted_index;
end