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
            R = ICP(filename, filename2, folder)
            counter = counter + 1
        end
        
        if counter > 1
            break
        end
    end
    toc()
end