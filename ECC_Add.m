%file:Add.m
function [ resx,resy ] = ECC_Add( a,b,p,x1,y1,x2,y2 )



%double 2P
if x1==x2 && y1==y2
    n= 3*x1^2+a;
    d= 2*y1;
    if  ~isinf( n)|| ~isinf( d )  
    m=ECC_modfrac(n,d,p);
    resx = mod(m^2-x1-x2,p);
    resy = mod(m*(x1-resx)-y1,p);
    else 
        resx=255;
        resy=255;
    end
end

if x1==x2 && y1~=y2
    resx = 255;
    resy = 255;
end
% addition P+Q=R
if x1 ~= x2
    n=y2-y1;
    d=x2-x1;
   
    if  ~isinf( n)|| ~isinf( d )  
    m=ECC_modfrac(n,d,p);
    resx = mod(m^2-x1-x2,p);
    resy = mod(m*(x1-resx)-y1,p); 
    else 
        resx=255;
        resy=255;
    end
end
end