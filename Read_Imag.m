
function [InputImage]=Read_Imag(InputImage)

% Convert image to greyscale
if (size(InputImage,3)==3)
InputImage=rgb2gray(InputImage);
end

% Resize the image to required size
InputImage=imresize(InputImage, [300 300]);
InputImage=double(InputImage);
disp('Image is readed and converted to grayscale');
end