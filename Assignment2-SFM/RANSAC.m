function F = RANSAC( x1, y1, x2, y2 )
    RandX1 = zeros(8,1);
    RandY1 = zeros(8,1);
    RandX2 = zeros(8,1);
    RandY2 = zeros(8,1);
    
    
    r = randi([1 length(x1)],1,8);

    for i = 1: length(r)
        RandX1(i,1) = x1(r(1,i), 1);
        RandY1(i,1) = y1(r(1,i), 1);
        RandX2(i,1) = x2(r(1,i), 1);
        RandY2(i,1) = y2(r(1,i), 1);
    end
    
    F = FundamentalMatrix(RandX1, RandY1, RandX2, RandY2);
    
    for i = 1: length(RandX1)
        p1 = [RandX1(i, 1); RandY1(i, 1); 1];
        p2 = [RandX2(i, 1); RandY2(i, 1); 1];
        
        Fp1 = F*p1;
        Fp2 = F'*p2;
        noemer = (p2'* Fp1)^2;
        
        di = noemer/(Fp1(1)+ Fp2(2) + Fp1(1)+ Fp2(2))

    end
end

