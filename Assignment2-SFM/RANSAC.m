function [F, bestInliers] = RANSAC( x1, y1, x2, y2 )
    totalPoints = 20
    RandX1 = zeros(totalPoints,1);
    RandY1 = zeros(totalPoints,1);
    RandX2 = zeros(totalPoints,1);
    RandY2 = zeros(totalPoints,1);
    
    bestInlierCount = 0;
    bestInliers = [];
    for j = 1:100
        r = randi([1 length(x1)],1,totalPoints);

        for i = 1: length(r)
            RandX1(i,1) = x1(r(1,i), 1);
            RandY1(i,1) = y1(r(1,i), 1);
            RandX2(i,1) = x2(r(1,i), 1);
            RandY2(i,1) = y2(r(1,i), 1);
        end

        F = FundamentalMatrix(RandX1, RandY1, RandX2, RandY2);

        inliers = [] ;
        inlierCount = 0;
        for i = 1: length(x1)
            p1 = [x1(i, 1); y1(i, 1); 1];
            p2 = [x2(i, 1); y2(i, 1); 1];

            Fp1 = F*p1;
            Fp2 = F'*p2;
            noemer = (p2'* Fp1)^2;

            di = noemer/(Fp1(1)^2+ Fp2(2)^2 + Fp1(1)^2+ Fp2(2)^2);
            threshold = 2.7722e-07;
            if di < threshold
                inlierCount = inlierCount + 1;
                inliers = [inliers, i];
            end  
        end
        if inlierCount > bestInlierCount
           bestInlierCount = inlierCount;
           bestInliers = inliers;
        end
    end
    total = i
    bestInlierCount
end

