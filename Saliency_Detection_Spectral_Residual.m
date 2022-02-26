clear
clc

%% Read image from file
inImg = im2double(rgb2gray(imread('/Users/jin/Q_Mac/localdata/saliency_detection/1242/obj4_0.png')));
%%inImg = imresize(inImg, 64/size(inImg, 2));

%% Spectral Residual
myFFT = fft2(inImg);
myLogAmplitude = log(abs(myFFT));
myPhase = angle(myFFT);
mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
saliencyMap = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2;

%% After Effect
saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [10, 10], 1.5)));
imshow(saliencyMap);