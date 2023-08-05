%file:modfrac.m

function y = ECC_modfrac( n,d,m )


n=mod(n,m);
d=mod(d,m);

% multiplicative inverse
i=1;
while mod(d*i,m) ~=1
    i=i+1;
end

y=mod(n*i,m);
end