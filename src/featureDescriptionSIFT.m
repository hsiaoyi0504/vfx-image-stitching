function [features,featuresRow,featuresCol] = featureDescriptionSIFT(imgIn,featureMap,Gx,Gy)
	[row,col] = find(featureMap==1);
	features = [];
	featuresRow = [];
	featuresCol = [];
	for i = 1:size(row,1)
		if(row(i)-8 > 0 && row(i)+8 < size(imgIn,1) && col(i)-8 > 0 && col(i)+8 < size(imgIn,2))
			feature = [];
            for bx = -2:1
                for by = -2:1
                    blockFeature = zeros(1,8);
                    blockGx = Gx(row(i)+bx*4:row(i)+(bx+1)*4,col(i)+by*4:col(i)+(by+1)*4);
                    blockGy = Gy(row(i)+bx*4:row(i)+(bx+1)*4,col(i)+by*4:col(i)+(by+1)*4);
                    for x = 1:4
                        for y = 1:4
                            gx = blockGx(x,y);
                            gy = blockGy(x,y);
                            if(gx>=0&&gy>=0)
                                if(gx>gy)
                                    blockFeature(1) = blockFeature(1) + 1;
                                else
                                    blockFeature(2) = blockFeature(2) + 1;
                                end
                            elseif(gx>=0&&gy<0)
                                if(gx>-gy)
                                    blockFeature(8) = blockFeature(8) + 1;
                                else
                                    blockFeature(7) = blockFeature(7) + 1;
                                end
                            elseif(gx<0&&gy<0)
                                if(-gx>-gy)
                                    blockFeature(5) = blockFeature(5) + 1;
                                else
                                    blockFeature(6) = blockFeature(6) + 1;
                                end
                            else
                                if(-gx>gy)
                                    blockFeature(4) = blockFeature(4) + 1;
                                else
                                    blockFeature(3) = blockFeature(3) + 1;
                                end
                            end
                        end
                    end
                    feature = [feature,blockFeature];
                end
            end
            features = [features;feature];
            %features = [ features; reshape(imgIn(row(i)-2:row(i)+2,col(i)-2:col(i)+2),1,[]);];
			featuresRow = [featuresRow; row(i)];
			featuresCol = [featuresCol; col(i)];
		end
	end
end