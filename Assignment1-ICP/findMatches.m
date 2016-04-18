function [BPCm, TPCm, distance] = findMatches(BPC, TPC)
[b, d] = dsearchn(BPC,TPC);
t = 1:length(b);
t = t';
A = [t, b, d];
D = sortrows(A,[2 3]);
matchIndex = zeros(1,3);

previous = 0;
for i = 1:length(D)
    if D(i, 2) ~= previous
        previous = D(i, 2);
        matchIndex = vertcat(matchIndex, D(i, :));
    end
end
matchIndex = matchIndex(2:end, :);
distance = mean(matchIndex(:,3));
BPCm = BPC(matchIndex(:,2),:);
TPCm = TPC(matchIndex(:,1),:);

end

