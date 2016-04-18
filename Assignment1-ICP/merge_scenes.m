function merge_scenes()
close all
folder = 'data';
directory = strcat(pwd, '\',folder,'\');
contents = dir(directory);

    for i = 1:numel(contents)-7
        filename = contents(i).name;
        filename2 = contents(i+7).name;
        [path, name, ext] = fileparts(filename);
        [path2, name2, ext2] = fileparts(filename2);
        
        if strcmp(ext, '.pcd') && length(name) == 10
            R = ICP(filename, filename2, folder)
            break
        end
    end
end