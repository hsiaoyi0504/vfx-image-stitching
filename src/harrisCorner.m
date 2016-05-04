function [cornerMap,R] = harrisCorner(imgIn,sigma1,sigma2,k)
	if(~exist('sigma1','var'))
		sigma1 = 0.5;
	end
	if(~exist('sigma2','var'))
		sigma2 = 0.5;
	end
	if(~exist('k','var'))
		k = 0.04;
	end
	if(size(imgIn,3) == 3)
		grayImg = rgb2gray(imgIn/255);
		grayImg = grayImg * 255;
	elseif(size(imgIn,3) == 1)
		grayImg = imgIn;
	end
	g_denoise = fspecial('gaussian', [3 3], sigma1);
	grayImg = imfilter(grayImg,g_denoise,'same','conv');
	g = fspecial('gaussian',[3 3],sigma2);
	[Gx, Gy] = imgradientxy(grayImg,'prewitt');
	Gx2 = Gx .* Gx;
	Gy2 = Gy .* Gy;
	Gxy = Gx .* Gy;
	Sx2 = imfilter(Gx2,g,'same','conv');
	Sy2 = imfilter(Gy2,g,'same','conv');
	Sxy = imfilter(Gxy,g,'same','conv');
	cornerMap = zeros(size(grayImg));
	detH = Sx2.*Sy2 - Sxy.*Sxy;
	traceH = Sx2 + Sy2;
	R = detH - k * (traceH.^2);
	cornerMap = imregionalmax(R);
	cornerMap(:,1:2) = 0;
	cornerMap(1:2,:) = 0;
	cornerMap(:,end-2:end) = 0;
	cornerMap(end-2:end,:) = 0;
end