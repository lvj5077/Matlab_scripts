c_intrinsic = cameraIntrinsics([605.0697021484375,605.45703125],[325.93792724609375,247.49156188964844],[480,640],'RadialDistortion',[0.14949573576450348, -0.49464672803878784, 0.42560458183288574],'TangentialDistortion',[0.00035660676076076925, 0.0001328527432633564]);


imcolor = imread('/Volumes/BlackSSD/myImage/OBS/colorRAW/1608253807.971332623.png');
imcolor3col1 = reshape(imcolor,480*640,3);
imdepth = imread('/Volumes/BlackSSD/myImage/OBS/depth/1608253807.971332623.png');
imdepth = double(imdepth);


s=1000;
fx = 605.0697021484375 ;
fy = 605.45703125;
skew = 0;
cx = 325.93792724609375;
cy = 247.49156188964844;

Z = imdepth/1000;
Z(Z(:,:)>4)=0;
[h,w] = size(imdepth);
u=repmat(1:w,[h,1]);
v=repmat(1:h,[w,1])';

X=(Z(:).*(u(:)-cx))/fx;
Y=(Z(:).*(v(:)-cy))/fy;

xyzPoints1 = [X(:),Y(:),Z(:)];

xyzPoints1 = xyzPoints1(Z(:)~=0,:);
imcolor3col1 = imcolor3col1(Z(:)~=0,:);
ptCloud1 = pointCloud(xyzPoints1, 'Color', imcolor3col1); 
figure,pcshow(ptCloud1)