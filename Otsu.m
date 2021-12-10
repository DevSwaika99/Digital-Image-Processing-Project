I=imread('291_hsi.bmp');
figure(1),imshow(I); 
figure(2),imhist(I); 

n=imhist(I); 
N=sum(n); 
max=0; 

for i=1:256
    P(i)=n(i)/N; %Computing the probability of each intensity level
end

for T=2:255      
    w0=sum(P(1:T)); 
    w1=sum(P(T+1:256));
    u0=dot([0:T-1],P(1:T))/w0; % class mean u0
    u1=dot([T:255],P(T+1:256))/w1; % class mean u1
    sigma=w0*w1*((u1-u0)^2); % compute sigma
    if sigma>max 
        max=sigma; 
        threshold=T-1;
    end
end

bw=im2bw(I,threshold/255);
figure(4),imshow(bw); 

img=bw;
img=double(img(:));
ima=max(img(:));
imi=min(img(:));
mse=std(img(:));
snr=20*log10((ima-imi)./mse)

% Measure Peak SNR
%[peaksnr, snr] = psnr(I_noise, I);
%fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
% fprintf('\n The SNR value is %0.4f \n', snr);
% fprintf('\n The MSE value is %0.4f \n', mse);