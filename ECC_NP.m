%file:NP.m
function [resx,resy] = ECC_NP( a,b,p,n,x,y )

resx=-1;
resy=-1;

if n ==1
    resx = x;
    resy = y;
    return;
end

if n>=2
    [xsub,ysub]=ECC_NP(a,b,p,n-1,x,y);
    if xsub==255 && ysub == 255 
        resx=255;
        resy=255;
    else
        [resx,resy]=ECC_Add(a,b,p,x,y,xsub,ysub);
    end
end

end