function [imgOut,rangeY,rangeX] = cylindricalProjection(imgIn,f)
	imgOut = zeros(size(imgIn));
	rangeY = floor(f * atan(size(imgIn,1)/f));
	rangeX = size(imgIn,2);
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
end