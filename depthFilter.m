clear
close all
clc
s=1000;
load('/Users/jin/Q_Mac/data/iphone_ego_summary/MeanE.mat');
R_c2b = [    1     0     0
     0     -1     0
     0     0    -1];
% t_c2b = [-0.028, -0.020, 0.0]';      
t_c2b = [-0.00, -0.00, 0.0]';   

% R_c2b = eye(3);
path = "/Volumes/BlackSSD/iPhone12_2_22_2021/data7long/";
% video = VideoReader(path+"Frames.m4v");

traj = importdata(path+"ARposes.txt");
ptCloud2 = pointCloud([0,0,0],'Color',[0,0,0]);
intrinsics = importdata(path+"Frames.txt");
intrinsics(:,3:6) = intrinsics(:,3:6);

fff = fopen(path+"FramesDpt.depth");
M_depth =[];
M_depth = fread(fff,'float');
totalImage = length(M_depth)/(192*256);
M_depth  = reshape(M_depth,[256,192,totalImage]);

fff = fopen(path+"FramesDptcfd.depth");
M_cfd =[];
M_cfd = fread(fff,'uint8');
totalImage = length(M_cfd)/(192*256);
M_cfd  = reshape(M_cfd,[256,192,totalImage]);
% totalImage = 2;
for frameNum = 1:totalImage
    frameNum
    imdepthcfd = M_cfd(:,:,frameNum);
    imdepthcfd = double(imdepthcfd);
    imdepthcfd = imrotate( imdepthcfd , -90 );
    imdepthcfd = fliplr(imdepthcfd);
    
    imdepth = M_depth(:,:,frameNum);
    imdepth = double(imdepth);
    imdepth = imrotate( imdepth , -90 );
    imdepth = fliplr(imdepth); 
    Z1 = uint16(1000*imdepth);
    imwrite(Z1,path+"depth/"+num2str(frameNum)+".png");
    
    
    [~,threshold] = edge(imdepth,'sobel');
    fudgeFactor = 0.5;
    BWs = edge(imdepth,'sobel',threshold * fudgeFactor);

    se = offsetstrel('ball',4,4);

    dilatedI = imdilate(255*uint8(BWs),se);
    imdepth(dilatedI(:,:)~=0)=0;
    Z2 = imdepth;
    Z2(Z2(:,:)>4)=0;
    Z2(Z2(:,:)<0.25)=0;
    Z2(imdepthcfd(:,:)<1.5)=0;
    imwrite(uint16(1000*Z2),path+"depth_filter/"+num2str(frameNum)+".png");
%     imdepth = double(imdepth);
%     imdepth = imresize(imdepth,[1440,1920]);


    
	Z3 = interp1(meanE(:,1),meanE(:,2),Z2(:,:));
    imwrite(uint16(1000*Z3),path+"depth_cfd/"+num2str(frameNum)+".png");
end

figure,
dd = imread(path+"depth/"+num2str(100)+".png");
subplot(1,3,1),imagesc(dd),colorbar
dd = imread(path+"depth_filter/"+num2str(100)+".png");
subplot(1,3,2),imagesc(dd),colorbar
dd = imread(path+"depth_cfd/"+num2str(100)+".png");
subplot(1,3,3),imagesc(dd),colorbar
