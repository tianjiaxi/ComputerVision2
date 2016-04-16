R = eye(3);
t = 0;

A1 = readPcd('data/0000000000.pcd');
A1(:,4) = [];

A2 = readPcd('data/0000000001.pcd');
A2(:,4) = [];

centroidA1 = sum(A1)/ length(A1);
centroidA2 = sum(A2)/length(A2);

A1 = bsxfun(@minus, A1, centroidA1);

A2 = bsxfun(@minus, A2, centroidA1);

[k, d] = dsearchn(A1,A2);
A = [0,0,0];
for i = 1:length(k)
    A = A + (A1(k(i),:)).*(A2(i,:));
end

[U, S, V] = svd(A);

R = U*V';

T = (centroidA1 - centroidA2)*R;


TPC = bsxfun(@plus,A1*R,T)



for i = 1:length(A1(:,1))
    distances = distances + A(i,:) -TPC(i,:);
end

avgdistances/ length(A1);

if(avgdistances) < 0,0012
   break 
end