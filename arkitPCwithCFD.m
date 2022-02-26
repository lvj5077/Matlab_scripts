maclear
close all
clc
s=1000;
% load('/Users/jin/Q_Mac/data/iphone_ego_summary/MeanE.mat');
R_c2b = [    1     0     0
     0     -1     0
     0     0    -1];
% t_c2b = [-0.028, -0.020, 0.0]';      
t_c2b = [-0.00, -0.00, 0.0]';   

% R_c2b = eye(3);
path = "/Users/jin/Desktop/ppp/2021-11-12T16-53-30";
video = VideoReader(path+"/Frames.m4v");

traj = importdata(path+"/ARposes.txt");
% traj = importdata("/Volumes/BlackSSD/drone_04_2021/drone_4_15/4/2021-04-15T18-23-03_top/ARposes.txt");
ptCloud2 = pointCloud([0,0,0],'Color',[0,0,0]);
intrinsics = importdata(path+"/Frames.txt");
intrinsics(:,3:6) = intrinsics(:,3:6);

fff = fopen(path+"/FramesDpt.depth");
M_depth =[];
M_depth = fread(fff,'float');
totalImage = length(M_depth)/(192*256);
M_depth  = reshape(M_depth,[256,192,totalImage]);

fff = fopen(path+"/FramesDptcfd.depth");
M_cfd =[];
M_cfd = fread(fff,'uint8');
totalImage = length(M_cfd)/(192*256);
M_cfd  = reshape(M_cfd,[256,192,totalImage]);

A = repmat(traj(:,1),[1 length(intrinsics(:,1))]);
[minValue,gtclosestIndex] = min(abs(A-intrinsics(:,1)'));
traj = traj(gtclosestIndex,:);
%%
ptCloud2 = pointCloud([0,0,0],'Color',[0,0,0]);


T1(1:3,1:3) = quat2rotm(traj(1,5:8));
T1(1:3,4) =(traj(1,2:4))';
% totalImage = 1700;

for frameNum = 1:10:totalImage
    frameNum/totalImage*100
    imdepthcfd = M_cfd(:,:,frameNum);
    imdepthcfd = double(imdepthcfd);
    imdepthcfd = imrotate( imdepthcfd , -90 );
    imdepthcfd = fliplr(imdepthcfd);
    fx = intrinsics(frameNum,3)/7.5;
    fy = intrinsics(frameNum,4)/7.5;
    cx = intrinsics(frameNum,5)/7.5;
    cy = intrinsics(frameNum,6)/7.5;
%     color_pth = path+"/color/"+num2str(intrinsics(i,2))+".png";
%     depth_pth = path+"/depth/"+num2str(intrinsics(i,2))+".png";
%     imcolor = imread(color_pth);
    frame = read(video,frameNum);
    imcolor = imresize(frame,[192,256]);
%     imdepth = imread(depth_pth);
    imcolor3col1 = reshape(imcolor,256*192,3);%%256*192
    imdepth = M_depth(:,:,frameNum);
    imdepth = double(imdepth);
    imdepth = imrotate( imdepth , -90 );
    imdepth = fliplr(imdepth); 
    
%     [~,threshold] = edge(imdepth,'sobel');
%     fudgeFactor = 0.5;
%     BWs = edge(imdepth,'sobel',threshold * fudgeFactor);
% 
%     se = offsetstrel('ball',4,4);
% 
%     dilatedI = imdilate(255*uint8(BWs),se);
%     imdepth(dilatedI(:,:)~=0)=0;
%     imdepth = double(imdepth);
%     imdepth = imresize(imdepth,[1440,1920]);

    Z = zeros(192,256);
%     
%     [~,threshold] = edge(imdepth,'sobel');
%     fudgeFactor = 0.5;
%     BWs = edge(imdepth,'sobel',threshold * fudgeFactor);
% 
%     se = offsetstrel('ball',2,2);
%     dilatedI = imdilate(255*uint8(BWs),se);
%     imdepth_temp = imdepth;
%     for i =3:190
%         for j = 3:253
%             if (dilatedI(i,j) == 255)
%                 surround = imdepth_temp(i-1:i+1,j-1:j+1);
%                 surroundN = reshape(surround,[9,1]);
%                 imdepth(i,j) = min(surroundN);
% 
%             end
%         end
%     end
%     
    step = 1;
    Z(1:step:192,1:step:256) = imdepth(1:step:192,1:step:256);
    
    

    
%     Z = Z/1000;
    Z(Z(:,:)>4)=0;
    Z(Z(:,:)<0.20)=0;
    Z(imdepthcfd(:,:)<1.5)=0;
    
%     Z = interp1(meanE(:,1),meanE(:,2),Z(:,:));
    
    [h,w] = size(imdepth);
    u=repmat(1:w,[h,1]);
    v=repmat(1:h,[w,1])';

    X=(Z(:).*(u(:)-cx))/fx;
    Y=(Z(:).*(v(:)-cy))/fy;

    xyzPoints = [X(:),Y(:),Z(:)];

    xyzPoints = xyzPoints(Z(:)~=0,:);
    imcolor3col1 = imcolor3col1(Z(:)~=0,:);
%     ptCloud2 = pointCloud(xyzPoints, 'Color', imcolor3col1); 


    T1= eye(4);
    T2= eye(4);

    T2(1:3,1:3) = quat2rotm(traj(frameNum,5:8));
    T2(1:3,4) =(traj(frameNum,2:4))';
%     T1(1:3,1:3) = quat2rotm([traj(i,5:8)]);
    



    
    TT = eye(4);
    TT = inv(T1)*(T2);
    
    RR = TT(1:3,1:3);

    tt = TT(1:3,4);

    xyzPoints1_2c = (R_c2b*(RR*(R_c2b'*xyzPoints'-t_c2b)+tt)+t_c2b)';
%     xyzPoints1_2c = xyzPoints;
    ptCloud1_2c = pointCloud(xyzPoints1_2c, 'Color', imcolor3col1); 
%     ptCloud1_2c = pcdenoise(ptCloud1_2c,'NumNeighbors',4,'Threshold',.1);

    ptCloud2 = pcmerge(ptCloud2,ptCloud1_2c,0.07);
end

figure,
pcshow(ptCloud2)
xlabel("X")
ylabel("Y")
zlabel("Z")

pcwrite(ptCloud2,path+"/pc.ply")
%%
figure, pcshow(ptCloud2),
hold on,
traj_xyz = (R_c2b*(traj(:,2:4)'))';
pt1 = plot3(traj_xyz(:,1),traj_xyz(:,2),traj_xyz(:,3),'r.','LineWidth',1);
% set(gcf,'color','w');
% set(gca,'color','w');
% axis off
% grid off
%%
% [val,idx] = min(traj_xyz(1:30*30,1));

% pt2 = plot3(traj_xyz(idx,1),traj_xyz(idx,2),traj_xyz(idx,3),'g*','LineWidth',4);
% pt3 = plot3(traj_xyz(end,1),traj_xyz(end,2),traj_xyz(end,3),'b*','LineWidth',4);

%
traj_color = zeros(length(traj_xyz),3);
traj_color(:,1) = 255;
traj_pc = pointCloud(traj_xyz, 'Color', traj_color);
all_pc = pcmerge(traj_pc,ptCloud2,0.001);
figure, pcshow(traj_xyz)
pcwrite(traj_pc,path+"/traj.ply")