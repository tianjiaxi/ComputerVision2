R = eye(3);
t = 0;

A1 = readPcd('data/0000000000.pcd');
A2 = readPcd('data/0000000001.pcd');

[k, d] = dsearchn(A1,A2)
%for i = 1:length(A1)
%    for j = 1:length(A2)
%        A1(i,:) - A2(j,:)
%    end
%end