function [ F, Epipole ] = FundamentalMatrix(x1, y1, x2, y2)
    A = [x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, ones(size(x1))];
    
    [U,D,V] = svd(A); %performing SVD on A
    
    [M,I] = min(max(D)); %finding the smallest singular value
    
    F = reshape(V(:,I),[3,3]);
    
    [Uf, Df, Vf] = svd(F); %performing SVD on F
    
    [M,I] = min(max(Df)); %finding the smallest singular value
    
    Dfp = Df;
    Dfp(I,I) = 0; %ensuring the rank is 2    
    
    F = Uf*Dfp*Vf';
    Epipole = Vf(:, 3);
end

