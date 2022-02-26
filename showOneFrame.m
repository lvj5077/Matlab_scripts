% clc
% close all
% clear
% path = "/Volumes/Extreme_LQ/testTraj_ipad_rgbdi/std_vs_mean/linear45/";
path = "/Users/jin/Q_Mac/Local_Data/02_03_2022/costco/2022-02-03T10-32-51/";
video = VideoReader(path+"Frames.m4v");
intrinsics = importdata(path+"Frames.txt");

fff = fopen(path+"FramesDpt.depth");
M_depth =[];
M_depth = fread(fff,'float');
totalImage = length(M_depth)/(192*256);
M_depth  = reshape(M_depth,[256,192,totalImage]);
fff = fopen(path+"FramesDptcfd.depth");
M_cdf =[];
M_cdf = fread(fff,'uint8');
% totalImage = length(A2)/(192*256);
M_cdf  = reshape(M_cdf,[256,192,totalImage]);
%%
% close all
% figure('units','normalized','outerposition',[0 0.4 .7 1]); 
frameNum = 3000;
% frameNum = 2520;
% frameNum = 780;
% frameNum = 1370;
% frame = read(video,frameNum);
frame = read(video,frameNum);
imwrite(frame,path+num2str(frameNum)+"colorFrame.png")
% frameNum = 240;
%
% frame = imread("/Users/jin/Downloads/Image 2-24-21 at 1.55 PM.jpg");
frame = imresize(frame,[192,256]);
% frame = uint8(255*ones(192,256,3)) - frame;
imcolor3col1 = reshape(frame,256*192,3);%%256*192
% subplot(4,3,1),imshow(frame)
% imdepth(imdepthcfd(:,:)<1.5)=0;
% imdepth(imdepth(:,:)>3.5)=0;

imdepth = M_depth(:,:,frameNum);
imdepth = double(imdepth);
imdepth = imrotate( imdepth , -90 );
imdepth = fliplr(imdepth);
imwrite( ind2rgb(im2uint8(mat2gray(imdepth)), parula(256)), path+num2str(frameNum)+"depthFrame.png")


imdepthcfd = M_cdf(:,:,frameNum);
imdepthcfd = double(imdepthcfd);
imdepthcfd = imrotate( imdepthcfd , -90 );
imdepthcfd = fliplr(imdepthcfd);
imwrite( ind2rgb(im2uint8(mat2gray(imdepthcfd)), parula(256)), path+num2str(frameNum)+"cfdFrame.png")
% subplot(4,3,3),imagesc(imdepthcfd),colorbar

%
% imdepth = imresize(Res,[192,256]);
% imagesc(imdepth)

intrinsics(frameNum,3:6)/7.5
fx = intrinsics(frameNum,3)/7.5;
fy = intrinsics(frameNum,4)/7.5;
cx = intrinsics(frameNum,5)/7.5;
cy = intrinsics(frameNum,6)/7.5;
Z = imdepth;
% Z(imdepthcfd(:,:)<1.5)=0;
Z(Z(:,:)>3)=0;
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
% subplot(4,3,4:12),
%
figure,pcshow(ptCloud)
% set(gcf,'color','w');
% set(gca,'color','w');
% grid off
% axis off
pcwrite(ptCloud,path+num2str(frameNum)+"pc.ply")