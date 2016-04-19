function merge_scenes()
close all
tic()
folder = 'data';
directory = strcat(pwd, '\',folder,'\');
contents = dir(directory);
counter = 1
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

            BPCo = BPCo(1:50:length(BPCo),:);


            TPCo = readPcd(file2);
            TPCo(:,4) = [];

            TPCo = cleanData(TPCo);
            TPCo = TPCo(1:50:length(TPCo),:);


            R = ICP(BPCo, TPCo)
            counter = counter + 1
        end
        
        if counter > 2
            break
        end
    end
    toc()
end