
function [z,R,Cipher,newImg]=Pso_Fitness(r,InputImage)


[R_pubX,R_pubY]=ECC_NP(-7,10,487,r,13,46);
R= [R_pubX,R_pubY];
[Cipher,C2]=ECC_Encryption(InputImage,r, [R_pubX,R_pubY]);
newImg=ECC_Decryption(Cipher,r,C2);
z = psnr(newImg, InputImage);


end
