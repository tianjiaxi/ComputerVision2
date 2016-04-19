function [TPC] = ICP(BPCo, TPCo)

R = eye(3);
t = 0;


%scatter3(TPCo(:,1),TPCo(:,2),TPCo(:,3), 'filled', 'red');
%hold on
avgdistance = 1000;
oldDistance = 1001;
iterations =0;
    while 1 == 1

        [BPCm, TPCm, distance] = findMatches(BPCo, TPCo);
        
        if abs(oldDistance - distance) < 0.0001 || iterations > 10
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
        R = pinv(R);
        %R = R';

        T = centroidBPCm - centroidTPCm * R;
        %T = -T;
        

        TPC = bsxfun(@plus,TPCo*R,T);
        oldDistance = distance;
        iterations = iterations + 1
        TPCo = TPC;
        
    end

    scatter3(TPCo(1:5:end,1),TPCo(1:5:end,2),TPCo(1:5:end,3), '.', 'yellow' );
    hold on
    %scatter3(BPCo(1:5:end,1),BPCo(1:5:end,2),BPCo(1:5:end,3), '.', 'blue');
end
