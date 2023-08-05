%file:ECCDencryption.m
function [newImg] = ECC_Decryption(Cipher,k,R_pub,E,G)


%%
  [Row, Column]=size(Cipher);
  newImg = zeros(Row,Column);

%% E parameter and base point G
if(nargin<5)
  a=-7;
  b=10;
  p=487;

  GX=13;
  GY=46;
else
a=E(1);
b=E(2);
p=E(3);


GX=G(1);
GY=G(2);

end   


%% public key of reciver
C2X=R_pub(1);
C2Y=R_pub(2);

%%decryption
%kC2
[kC2X,kC2Y]=ECC_NP(a,b,p,k,C2X,C2Y);
 
kC2Y=mod(-1*kC2Y,p);

for i=1:1:Column
    for j=1:2:Row
    %decryption
    
    %C1-kC2
    [newImg(i,j),newImg(i,j+1)]=ECC_Add(a,b,p,Cipher(i,j),Cipher(i,j+1),kC2X,kC2Y);
  
    end
end
%%
end