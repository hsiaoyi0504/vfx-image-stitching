function [imgOut,rangeY,rangeX] = cylindricalProjection(imgIn,f)
	imgOut = zeros(size(imgIn));
	rangeY = size(imgIn,1);
	rangeX = floor(f*atan(size(imgIn,2)/f));
	for i = 1:rangeX
		for j = 1:rangeY
			x = f * tan(i/f);
			y = j * abs(cos(i/f));
			if(ceil(x)+1 > size(imgIn,2) || ceil(y)+1 > size(imgIn,1))
				continue;
			else
				for k = 1:3
					imgOut(j,i,k) = imgIn(ceil(y),ceil(x),k) * ( ceil(y) + 1 - y ) * ( ceil(x) + 1 - x ) ...
								  + imgIn(ceil(y),ceil(x)+1,k) * ( ceil(y) + 1 - y ) * ( x - ceil(x) ) ...
								  + imgIn(ceil(y)+1,ceil(x),k) * ( y - ceil(y) ) * ( ceil(x) + 1 - x )  ...
								  + imgIn(ceil(y)+1,ceil(x)+1,k) * ( y - ceil(y) ) * ( x - ceil(x) );
				end
			end
		end
	end
	while(imgOut(:,rangeX,:)==0)
		rangeX = rangeX - 1;
	end
	while(imgOut(:,rangeX,:)==0)
		rangeY = rangeY - 1;
	end
end