function [ cloudT ] = bestProcrustes( prevCloud, cloud)
% This function will get the procrustes transformation to transform the
% currect point cloud to the previous point cloud. the matlab built-in does
% not support different amounts of points, therefore we implemented a check
% to make sure the two clouds are of equal size. An improvement for this
% function would be to run the procustes a couple of times with randomly
% samples points and then take the transformation with the smallest
% distance/error from the matching and use that transformation on all the
% data points. This will provide you with all the points (which it fails to
% do now) and it will do the transformation with a good estimate of the
% ideal transformation.

sizePrev = size(prevCloud, 1);
sizeCurr = size(cloud, 1);

if sizePrev == sizeCurr
    [~,cloudT] = procrustes(prevCloud, cloud);
else
   if sizePrev > sizeCurr
       prevCloudSub = prevCloud(randperm(sizePrev, sizeCurr), :);
       [~, cloudT] = procrustes(prevCloudSub, cloud);
   else
       cloudSub = cloud(randperm(sizeCurr, sizePrev), :);
       [~, cloudT] = procrustes(prevCloud, cloudSub); 
   end
end
end

