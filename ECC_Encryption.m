%file:ECCEncryption.m
function [Cipher,C2] = ECC_Encryption(InputImage,r,K_pub,E,G)


%%
  [Row, Column]=size(InputImage);
  Cipher = zeros(Row,Column);
  
  

%% %% E parameter and base point G
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
K_pubX=K_pub(1);
K_pubY=K_pub(2);


%private key for Alice
%RK_pub
[rKX,rKY] = ECC_NP(a,b,p,r,K_pubX,K_pubY);

%C2 = RG
[C2X,C2Y]=ECC_NP(a,b,p,r,GX,GY);
C2=[C2X,C2Y];

for i=1:1:Column
    for j=1:2:Row
    %encryption
    
    %C1 = M + RK_pub
    [Cipher(i,j),Cipher(i,j+1)]=ECC_Add(a,b,p,InputImage(i,j),InputImage(i,j+1),rKX,rKY);
  
    end
end
end