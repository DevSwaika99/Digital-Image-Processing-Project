input_image = imread('291_hsi.bmp');
input_image = uint8(input_image);
figure, imshow(input_image); title('Input Image');

% Converting the HSI image to the grayscale image
input_image = rgb2gray(input_image);

% Convert the image to double
input_image = double(input_image);
filtered_image = zeros(size(input_image));

% Robert Operator Mask
Mx = [1 0; 0 -1];
My = [0 1; -1 0];

for i = 1:size(input_image, 1) - 1
	for j = 1:size(input_image, 2) - 1
		Gx = sum(sum(Mx.*input_image(i:i+1, j:j+1)));
		Gy = sum(sum(My.*input_image(i:i+1, j:j+1)));
		filtered_image(i, j) = sqrt(Gx.^2 + Gy.^2);
	end
end

filtered_image = uint8(filtered_image);
%figure, imshow(filtered_image); title('Filtered Image');

% Define a threshold value
thresholdValue = 100;
output_image = max(filtered_image, thresholdValue);
output_image(output_image == round(thresholdValue)) = 0;

% Displaying Output Image
output_image = im2bw(output_image);
figure, imshow(output_image); title('Edge Detected Image');

img=output_image;
img=double(img(:));
ima=max(img(:));
imi=min(img(:));
mse=std(img(:));
snr=20*log10((ima-imi)./mse);

% Measure Peak SNR and MSE
fprintf('\n The MSE value is %0.4f ', mse);