I = imread('291.bmp');
figure();
imshow(I);
I = imgaussfilt(I,2);
figure();
imshow(I);