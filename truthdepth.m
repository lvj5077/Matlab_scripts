clear
close all

fx = 434.36;
fy = 434.36;
skew = 0;
cy = 320.33;
cx = 239.52;
%%

depth_path = [ '/Users/jin/Downloads/truthDepth/3.73/FramesDpt.depth'];
fff = fopen(depth_path);
A2 =[];
A2 = fread(fff,'float');
totalImage = length(A2)/(640*480);
A2  = reshape(A2,[640,480,totalImage]);
b = A2(320,240,300:500);
b = reshape(b,[length(b),1]);
mean(b)
std(b)

%%
depth_path = [ '/Users/jin/Downloads/truthDepth/3.73/FramesDpt.depth'];
fff = fopen(depth_path);
A2 =[];
A2 = fread(fff,'float');
totalImage = length(A2)/(640*480);
A2  = reshape(A2,[640,480,totalImage]);
b = A2(:,:,400);
Z = b;
[h,w] = size(b);
u=repmat(1:w,[h,1]);
v=repmat(1:h,[w,1])';

X=(Z(:).*(u(:)-cx))/fx;
Y=(Z(:).*(v(:)-cy))/fy;

xyzPoints = [X(:),Y(:),Z(:)];

xyzPoints = xyzPoints(Z(:)~=0,:);

ptCloud = pointCloud(xyzPoints); 
figure,pcshow(ptCloud)

%%
clear
fx = 212.7505;
fy = 212.7505;
skew = 0;
cy = 126.4288;
cx = 95.6402;

depth_path = [ '/Volumes/Extreme_LQ/testTraj_ipad_rgbdi/std_vs_mean/linear40/FramesDpt.depth'];
fff = fopen(depth_path);
A2 =[];
A2 = fread(fff,'float');
totalImage = length(A2)/(192*256);
A2  = reshape(A2,[256,192,totalImage]);
b = A2(:,:,300);
Z = b;
[h,w] = size(b);
u=repmat(1:w,[h,1]);
v=repmat(1:h,[w,1])';

X=(Z(:).*(u(:)-cx))/fx;
Y=(Z(:).*(v(:)-cy))/fy;

xyzPoints = [X(:),Y(:),Z(:)];

xyzPoints = xyzPoints(Z(:)~=0,:);

ptCloud = pointCloud(xyzPoints); 
figure,pcshow(ptCloud)