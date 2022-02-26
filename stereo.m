I1 = imread("/Users/jin/Desktop/Fisheye_firstShot/translation_blackfly/200_1.bmp");
I2 = imread("/Users/jin/Desktop/Fisheye_firstShot/translation_blackfly/400_1.bmp");

I1 = imresize(I1,0.5);
I2 = imresize(I2,0.5);

cameraParams = cameraParameters('IntrinsicMatrix',IntrinsicMatrix,'RadialDistortion',radialDistortion); 
stereoParams = stereoParameters(cameraParams,cameraParams,eye(3),[10,0,0]);

[J1,J2] = rectifyStereoImages(I1,I2,stereoParams);


figure 
imshow(cat(3,J1(:,:,1),J2(:,:,2:3)),'InitialMagnification',50);

disparityMap = disparitySGM(im2gray(J1),im2gray(J2));
figure 
imshow(disparityMap,[0,64],'InitialMagnification',50);

xyzPoints = reconstructScene(disparityMap,stereoParams);

Z = xyzPoints(:,:,3);
mask = repmat(Z > 3200 & Z < 3700,[1,1,3]);
J1(~mask) = 0;
imshow(J1,'InitialMagnification',50);