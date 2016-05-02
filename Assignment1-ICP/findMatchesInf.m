function [BPCm, TPCm, distance] = findMatchesInf(BPC, TPC)
'doing find matches'
[b, d] = dsearchn(TPC,BPC);
t = 1:length(b);
t = t';
A = [t, b, d];
D = sortrows(A,[2 3]);
matchIndex = zeros(1,3);

previous = 0;
for i = 1:length(D)
    if D(i, 2) ~= previous
        previous = D(i, 2);
        if D(i,3) < 0.3
            matchIndex = vertcat(matchIndex, D(i, :));
        end
        
    end
end
matchIndex = matchIndex(2:end, :);
distance = mean(matchIndex(:,3));
BPCm = BPC(matchIndex(:,1),:);
TPCm = TPC(matchIndex(:,2),:);
lenbpcm = length(BPCm)
lentpcm = length(TPCm);

end
