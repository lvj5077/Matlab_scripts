c_intrinsic = cameraIntrinsics([605.0697021484375,605.45703125],[325.93792724609375,247.49156188964844],[480,640],'RadialDistortion',[0.14949573576450348, -0.49464672803878784, 0.42560458183288574],'TangentialDistortion',[0.00035660676076076925, 0.0001328527432633564]);


I_raw = imread('/Users/jin/Desktop/checkRC/raw.png');
I_rect = imread('/Users/jin/Desktop/checkRC/rect.png');

[J,newOrigin] = undistortImage(I_raw,c_intrinsic);

% figure,imshow(J)
% D: [0.14949573576450348, -0.49464672803878784, 0.00035660676076076925, 0.0001328527432633564, 0.42560458183288574]
% K: [605.0697021484375, 0.0, 325.93792724609375, 0.0, 605.45703125, 247.49156188964844, 0.0, 0.0, 1.0]
%%
figure,
A= I_raw;
B = I_rect;
C = imfuse(A,B,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
subplot(1,3,1),imshow(C)
title("raw vs rect")

%%
A= I_rect;
B = J;
C = imfuse(A,B,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
subplot(1,3,2),imshow(C)
title("rect vs undis")
%%
A= I_raw;
B = J;
C = imfuse(A,B,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
subplot(1,3,3),imshow(C)
title("raw vs undis")