function [imgOut] = blending(img1,img2)
	imgOut = zeros(size(img1));
	lengthX = size(img1,2);
	for i = 1:lengthX
		imgOut(:,i) = i/(lengthX-1) * img1(:,i) + (lengthX - 1 - i)/(lengthX-1) * img2(:,i);
	end