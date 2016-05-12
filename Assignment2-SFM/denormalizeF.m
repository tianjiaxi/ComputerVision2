function [ F ] = denormalizeF( F, T1, T2 )
%This function denormalizes F given F, T1 and T2.
    F = T2' * F * T1;
end

