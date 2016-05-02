function [BPCm, TPCm, distance] = findMatches3(BPC, TPC)
'doing find matches';
[b, d] = dsearchn(TPC,BPC);

BPCm = BPC;
TPCm = zeros(length(b), 3);

for i = 1:length(b)
    TPCm(i,:) = TPC(b(i),:);
end

distance = mean(d);
end
%this function does the most basic matching. It finds matching points in
%the base cloud for each point in the target cloud