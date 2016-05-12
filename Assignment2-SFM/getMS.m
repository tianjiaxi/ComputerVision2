function [ M, S ] = getMS( D )
%This function will get the Motion and Structure matrices from the D
%(pointview) matrix.

[U, W, V] = svd(D);

U3 = U(:, 1:3);
V3 = V(:, 1:3);
W3 = W(1:3,1:3);

M = U3 * (W3^0.5);
S = (W3^0.5) * V3';
end

