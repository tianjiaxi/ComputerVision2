R = eye(3);
t = 0;

BPC = readPcd('data/0000000000.pcd');
BPC(:,4) = [];

TPC = readPcd('data/0000000001.pcd');
TPC(:,4) = [];
avgdistance = 1000;

while avgdistance >= 0.0012
    centroidBPC = sum(BPC)/ length(BPC);
    centroidTPC = sum(TPC)/length(TPC);

    BPC = bsxfun(@minus, BPC, centroidBPC);

    TPC = bsxfun(@minus, TPC, centroidTPC);

    [k, d] = dsearchn(BPC,TPC);
    A = [0,0,0];
    for i = 1:length(k)
        A = A + (BPC(k(i),:)).*(TPC(i,:));
    end

    [U, S, V] = svd(A);

    R = U*V';

    T = (centroidBPC - centroidTPC)*R;


    TPC = bsxfun(@plus,TPC*R,T)
    distances = 0;
    for i = 1:length(TPC(:,1))
        distances = distances + BPC(i,:) - TPC(i,:);
    end

    avgdistance = distances / length(TPC)
end
