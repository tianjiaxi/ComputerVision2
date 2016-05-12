function StructureFromMotion()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
PointViewMatrixExample;
splice = 202;
totalFrames = size(D,1);

cloud = [];
%if splice == totalFrames
    [M, S] = getMS(D);
    cloud = S;
%else
%     for i = 1:totalFrames-(splice-1)
%         [i:i+splice-1]
%     end
    %for i = 1:totalFrames/splice
%end
scatter3(cloud(1,:), cloud(2,:), cloud(3,:));

end

