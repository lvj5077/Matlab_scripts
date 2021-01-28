clc
close all
clear
path = "/Users/jin/Q_Mac/data/person/Arkit/2021-01-28T15-08-48/";
v = VideoReader(path+"Frames.m4v");
intrinsics = importdata(path+"Frames.txt");
frameNum = 6;
frame = read(v,frameNum);
frame = imresize(frame,[192,256]);
imcolor3col1 = reshape(frame,256*192,3);%%256*192
fff = fopen(path+"FramesDpt.depth");
A2 =[];
A2 = fread(fff,'float');
totalImage = length(A2)/(192*256);
A2  = reshape(A2,[256,192,totalImage]);

imdepth = A2(:,:,frameNum);
imdepth = double(imdepth);
imdepth = imrotate( imdepth , -90 );
imdepth = fliplr(imdepth);
% imagesc(imdepth)
% imwrite( ind2rgb(im2uint8(mat2gray(imdepth)), parula(256)), 'imdepth.png')


fx = intrinsics(frameNum,3)/7.5;
fy = intrinsics(frameNum,4)/7.5;
cx = intrinsics(frameNum,5)/7.5+1;
cy = intrinsics(frameNum,6)/7.5+1;
Z = imdepth;
% Z(Z(:,:)>12)=0;
Z(Z(:,:)<0.25)=0;
[h,w] = size(imdepth);
u=repmat(1:w,[h,1]);
v=repmat(1:h,[w,1])';

X=(Z(:).*(u(:)-cx))/fx;
Y=(Z(:).*(v(:)-cy))/fy;

xyzPoints = [X(:),Y(:),Z(:)];
xyzPoints = xyzPoints(Z(:)~=0,:);
imcolor3col1 = imcolor3col1(Z(:)~=0,:);
ptCloud = pointCloud(xyzPoints, 'Color', imcolor3col1);

pcshow(ptCloud)