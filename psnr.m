function peaksnr = psnr(distImg, origImg)

origImg = double(origImg);
distImg = double(distImg);

[M, N] = size(origImg);
error = origImg - distImg;
MSE = sum(sum(error .* error)) / (M * N);


if(MSE > 0)
peaksnr = 10*log(255*255/MSE) / log(10);
else
peaksnr = 99;
end

end
