R = eye(3);
t = 0;

BPCo = readPcd('data/0000000000.pcd');
BPCo(:,4) = [];

TPCo = readPcd('data/0000000001.pcd');
TPCo(:,4) = [];
avgdistance = 1000;
iterations =0;
while avgdistance >= 0.0012
    
    
    centroidBPC = sum(BPCo)/ length(BPCo);
    centroidTPC = sum(TPCo)/length(TPCo);

    BPC = bsxfun(@minus, BPCo, centroidBPC);

    TPC = bsxfun(@minus, TPCo, centroidTPC);

    [k, d] = dsearchn(BPC,TPC);
    A = [0,0,0];
    for i = 1:length(k)
        A = A + (BPC(k(i),:)).*(TPC(i,:));
    end

    [U, S, V] = svd(A);

    R = U*V';

    T = (centroidBPC - centroidTPC)*R;


    TPC = bsxfun(@plus,TPCo*R,T);
    distances = 0;
    for i = 1:length(TPCo(:,1))
        distances = distances + BPCo(i,:) - TPC(i,:);
    end

    avgdistance = distances / length(TPC);
    iterations = iterations + 1
    TPCo = TPC;
end
