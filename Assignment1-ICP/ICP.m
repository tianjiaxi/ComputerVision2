function R = ICP(filename1, filename2, folder)

R = eye(3);
t = 0;

file1 = strcat(folder, '\', filename1);
file2 = strcat(folder, '\',filename2);

BPCo = readPcd(file1);
BPCo(:,4) = [];

BPCo = cleanData(BPCo);
BPCo = BPCo(1:100:length(BPCo), :);

TPCo = readPcd(file2);
TPCo(:,4) = [];

TPCo = cleanData(TPCo);
TPCo = TPCo(1:100:length(TPCo), :);

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
    scatter3(TPC(:,1),TPC(:,2),TPC(:,3));
    hold;
end
