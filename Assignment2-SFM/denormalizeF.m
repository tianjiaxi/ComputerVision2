function [ F ] = denormalizeF( F, T1, T2 )
    F = T2' * F * T1;
end

