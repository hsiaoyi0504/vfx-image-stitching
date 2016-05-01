function [cornerMap,R] = harrisCorner(imgIn,threshold,sigma1,sigma2,k)
	if(~exist('threshold','var'))
		threshold = 0;
	end
	if(~exist('sigma1','var'))
		sigma1 = 1;
	end
	if(~exist('sigma2','var'))
		sigma2 = 1;
	end
	if(~exist('k','var'))
		k = 0.01;
	end
	if(size(imgIn,3) == 3)
		grayImg = rgb2gray(imgIn);
	elseif(size(imgIn,3) == 1)
		grayImg = imgIn;
	end
	g = fspecial('gaussian');
	[Gx, Gy] = imgradientxy(grayImg,'prewitt');
	Gx2 = Gx .* Gx;
	Gy2 = Gy .* Gy;
	Gxy = Gx .* Gy;
	Sx2 = imfilter(Gx2,g,'same');
	Sy2 = imfilter(Gy2,g,'same');
	Sxy = imfilter(Gxy,g,'same');
	cornerMap = zeros(size(grayImg));
	detH = Sx2.*Sy2 - Sxy.*Sxy;
	traceH = Sx2 + Sy2;
	R = detH - k * (traceH.^2);
	cornerMap(find(R>threshold)) = 255;
end