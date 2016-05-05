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
		if(counter)==0
			extracted_index = sorted_index(1);
			sorted_row = sorted_row(2:end);
			sorted_col = sorted_col(2:end);
			sorted_index = sorted_index(2:end);
			sorted_r = sorted_r(2:end);
			counter = 1;
		else
			dist = dist_max;
			while(dist>0)
				for i = 1:size(sorted_index)
					before_num = size(extracted_index,1);
					% canBeChosen = true;
					[row1,col1] = ind2sub(size(featureMapIn),sorted_index(i));
					for j = 1:size(extracted_index)
						[row2,col2] =  ind2sub(size(featureMapIn),extracted_index(j));
						if( (row1-row2)^2 + (col1-col2)^2 < dist)
							if(j==size(extracted_index))
								extracted_index = [ extracted_index; sorted_index(i)];
								counter = counter + 1;
							else
								continue;
							end
						else
							break;
						end
					end
					if(size(extracted_index,1)~=before_num)
						if(counter==num)
							dist = dist_max + 1;
						else
							dist = dist_max;
						end
						break;
					end
					if(dist == dist_max + 1)
						break;
					end
				end
			end
		end
	end
	% sorted_sub = ind2sub(sorted_index);
	% outMap = zeros(size(inMap));
	% size_count = 0;
	% while(size_count<num)
	% 	r = round(sqrt(size(outMap,1)^2+size(outMap,2)^2));

	% end
	% outMap = sorted_index;
end