% clc
close all
clear
path = "/Volumes/BlackSSD/iphoneCheck/iphoneVerifyIpad/2021-02-12T13-45-41/";
v = VideoReader(path+"Frames.m4v");
intrinsics = importdata(path+"Frames.txt");
frameNum = 300;
frame = read(v,frameNum);
imwrite(frame,path+num2str(frameNum)+"colorFrame.png")
frame = imresize(frame,[192,256]);
% frame = uint8(255*ones(192,256,3)) - frame;
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
imwrite( ind2rgb(im2uint8(mat2gray(imdepth)), parula(256)), path+num2str(frameNum)+"depthFrame.png")

intrinsics(frameNum,3:6)/7.5
fx = intrinsics(frameNum,3)/7.5;
fy = intrinsics(frameNum,4)/7.5;
cx = intrinsics(frameNum,5)/7.5;
cy = intrinsics(frameNum,6)/7.5;
Z = imdepth;
% Z(Z(:,:)>5)=0;
% Z(Z(:,:)<0.25)=0;
[h,w] = size(imdepth);
u=repmat(1:w,[h,1]);
v=repmat(1:h,[w,1])';

X=(Z(:).*(u(:)-cx))/fx;
Y=(Z(:).*(v(:)-cy))/fy;

xyzPoints = [X(:),Y(:),Z(:)];
xyzPoints = xyzPoints(Z(:)~=0,:);
imcolor3col1 = imcolor3col1(Z(:)~=0,:);
ptCloud = pointCloud(xyzPoints, 'Color', imcolor3col1);
% pcshow(ptCloud)
pcwrite(ptCloud,path+num2str(frameNum)+"pc.ply")

% 2*atan(((max(xyzPoints(:,2))-min(xyzPoints(:,2)))/(2*min(xyzPoints(:,3)))))*180/pi
% 2*atan(((max(xyzPoints(:,1))-min(xyzPoints(:,1)))/(2*min(xyzPoints(:,3)))))*180/pi