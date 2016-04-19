function R = ICP(BPCo, TPCo)

R = eye(3);
t = 0;


%scatter3(TPCo(:,1),TPCo(:,2),TPCo(:,3), 'filled', 'red');
%hold on
avgdistance = 1000;
iterations =0;
    while 1 == 1

        [BPCm, TPCm, distance] = findMatches(BPCo, TPCo);
        
        if distance < 0.0012 || iterations > 100
            distance
            break
        else
            distance
        end
        
        centroidTPCm = mean(TPCm);
        centroidBPCm = mean(BPCm);
        
        BPCm = bsxfun(@minus, BPCm, centroidBPCm);
        TPCm = bsxfun(@minus, TPCm, centroidTPCm);
        

        
        A = zeros(3,3);
        for i = 1:length(BPCm)
            A = A + (BPCm(i,:)' * TPCm(i,:));
        end

        [U, S, V] = svd(A);

        R = U*V';

        T = centroidBPCm - centroidTPCm * R;


        TPC = bsxfun(@plus,TPCo*R,T);
        
        iterations = iterations + 1
        TPCo = TPC;
        
    end
    c = {'red', 'blue','green','yellow','purple','orange'};
    scatter3(TPCo(:,1),TPCo(:,2),TPCo(:,3), '.', 'yellow' );
    hold on
    scatter3(BPCo(:,1),BPCo(:,2),BPCo(:,3), '.', 'blue');
end
