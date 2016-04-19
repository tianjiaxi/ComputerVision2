function findRTD()
%this function will find the rotation, translation and distance for every
%frame pair and stores it in RTD.mat which is used in merge_frames.m . This
%is corresponding to assignment 2.1.
close all
tic()
folder = 'data';
directory = strcat(pwd, '\',folder,'\');
contents = dir(directory);
counter = 1
BPC = [];
Rarray = eye(3);
Tarray = [0,0,0];
Darray = [0];
    for i = 1:numel(contents)-7
        filename = contents(i).name;
        filename2 = contents(i+7).name;
        [path, name, ext] = fileparts(filename);
        [path2, name2, ext2] = fileparts(filename2);
        
        if strcmp(ext, '.pcd') && length(name) == 10
            'starting with ICP'
            file1 = strcat(folder, '\', filename);
            file2 = strcat(folder, '\',filename2);

            BPCo = readPcd(file1);
            BPCo(:,4) = [];

            BPCo = cleanData(BPCo);

            BPCo = BPCo(1:25:length(BPCo),:);


            TPCo = readPcd(file2);
            TPCo(:,4) = [];

            TPCo = cleanData(TPCo);
            TPCo = TPCo(1:25:length(TPCo),:);
            
            %if isempty(BPC)
            %    'first'
            %    BPC = BPCo;
            %else
            %    'take previous target cloud'
            %end
            
            [Rn, Tn, D] = ICP2(BPCo, TPCo);
            Rarray = vertcat(Rarray, Rn);
            Tarray = vertcat(Tarray, Tn);
            Darray = vertcat(Darray, D);
            counter = counter + 1
        end
        
        if counter > 100
            break
        end
    end
    Rarray
    Tarray
    save('RTD','Rarray','Tarray', 'Darray')
    distanceMean = mean(Darray)
    toc()
end