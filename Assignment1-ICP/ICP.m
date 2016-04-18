function R = ICP(filename1, filename2, folder)

R = eye(3);
t = 0;

file1 = strcat(folder, '\', filename1);
file2 = strcat(folder, '\',filename2);

BPCo = readPcd(file1);
BPCo(:,4) = [];

BPCo = cleanData(BPCo);

BPCo = BPCo(1:50:length(BPCo),:);


TPCo = readPcd(file2);
TPCo(:,4) = [];

TPCo = cleanData(TPCo);
TPCo = TPCo(1:50:length(TPCo),:);


%scatter3(TPCo(:,1),TPCo(:,2),TPCo(:,3), 'filled', 'red');
%hold on
avgdistance = 1000;
iterations =0;
    while 1 == 1

        
        [BPCm, TPCm, distance] = findMatches(BPCo, TPCo);
        
        if distance < 0.0012 || iterations > 5
            distance
            break
        else
            distance;
        end
        
        centroidTPCm = mean(TPCm);
        centroidBPCm = mean(BPCm);
        
        BPCm = bsxfun(@minus, BPCm, centroidBPCm);
        TPCm = bsxfun(@minus, TPCm, centroidTPCm);
        

        
        A = [0,0,0];
        for i = 1:length(BPCm)
            A = A + (BPCm(i,:)).*(TPCm(i,:));
        end

        [U, S, V] = svd(A);

        R = U*V';

        T = (centroidBPCm - centroidTPCm)*R


        TPC = bsxfun(@plus,TPCo*R,T);
        
        iterations = iterations + 1
        TPCo = TPC;
        
    end
    iterations
    scatter3(TPCo(:,1),TPCo(:,2),TPCo(:,3), 'filled', 'yellow');
    hold on
    %scatter3(BPCo(:,1),BPCo(:,2),BPCo(:,3), 'filled', 'blue');
end
