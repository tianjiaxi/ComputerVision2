function StructureFromMotion(D)
%This function will either create a dense matrix from the point view matrix
%(if splice == totalFrames) or will attempt to do this for splices, which
%then later will be merged with the bestProcrustes() function. We remove
%columns that contain a 0.
%
PointViewMatrixExample;


totalFrames = size(D,1);
splice = totalFrames;
%splice = 3;

cloud = [];
if splice == totalFrames
    Ddense = D;
    Ddense(:,any(Ddense==0,1))=[];
    [M, S] = getMS(Ddense);
    cloud = S;
    scatter3(cloud(1,:), cloud(2,:), cloud(3,:));
else
%     for i = 1:totalFrames-(splice-1)
%         [i:i+splice-1]
%     end
    prevCloud = 0;
    for i = 1:round(totalFrames/splice)-1
        from = 1 + ((i-1) * splice)
        to = i * splice
        Ddense = D(from:to, :);
        Ddense(:,any(Ddense==0,1))=[];
        [M, S] = getMS(Ddense);
        cloud = S;
        if prevCloud ~= 0
            [cloud] = bestProcrustes(prevCloud', cloud');
            cloud = cloud';
        end
        scatter3(cloud(1,:), cloud(2,:), cloud(3,:));
        hold on
        prevCloud = cloud;
    end
end


end

