function merge_frames()
%merge_frames function uses the rotation and translations that are found by
%findRTD() and scatter plots the different point clouds in the global
%coordinate system.
load('RTD.mat', 'Rarray');
load('RTD.mat', 'Tarray');
load('RTD.mat', 'Darray');

folder = 'data';
directory = strcat(pwd, '\',folder,'\');
contents = dir(directory);
counter = 0;
R = zeros(3,3);
T = [0,0,0];
    for i = 1:numel(contents)-7
        filename = contents(i).name;
        filename2 = contents(i+7).name;
        [path, name, ext] = fileparts(filename);
        [path2, name2, ext2] = fileparts(filename2);
        
        if strcmp(ext, '.pcd') && length(name) == 10
            disp(['merging frame ', int2str(counter) ,' with frame ' , int2str(counter + 1)])
            file1 = strcat(folder, '\', filename);
            file2 = strcat(folder, '\',filename2);

            PCo = readPcd(file1);
            PCo(:,4) = [];
            PCo = cleanData(PCo);
            PCo = PCo(1:100:end,:);
            PC = PCo;
            for i = fliplr(1:counter)
                R = Rarray(i*3 + 1:i*3 + 3,:);
                PC = PC * pinv(R);   
            end
            T = Tarray(counter + 1,:);
            PC = bsxfun(@plus,PC,T);
            
            h = scatter3(PC(:,1),PC(:,2),PC(:,3), '.');
            h.MarkerFaceColor = [randi(1)/100 randi(1)/100 randi(1)/100];
            hold on
            counter = counter + 1;
            
    end
end

