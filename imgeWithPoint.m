clear
close all
clc
s=1000;

R_c2b = [0.0,-1.0,0.0, 
        -1.0,0.0,0.0, 
        0.0, 0.0, -1.0];
% t_c2b = [-0.028, -0.020, 0.0]';      
t_c2b = [-0.00, -0.00, 0.0]';   

% R_c2b = eye(3);
path = "/Users/jin/Q_Mac/data/person/Arkit/2021-01-26T19-02-17";
traj = importdata(path+"/ARposes_arkit.txt");
ptCloud2 = pointCloud([0,0,0],'Color',[0,0,0]);
intrinsics = importdata(path+"/Frames.txt");
intrinsics(:,3:6) = intrinsics(:,3:6);



A = repmat(traj(:,1),[1 length(intrinsics(:,1))]);
[minValue,gtclosestIndex] = min(abs(A-intrinsics(:,1)'));
traj = traj(gtclosestIndex,:);


% figure,
% subplot(3,1,1)
% plot(intrinsics(:,2),traj(:,2),'g'),grid minor
% 
% 
% subplot(3,1,2)
% plot(intrinsics(:,2),traj(:,3),'g'),grid minor
% % 
% 
% subplot(3,1,3)
% plot(intrinsics(:,2),traj(:,4),'g'),grid minor


ptCloud2 = pointCloud([0,0,0],'Color',[0,0,0]);

% for i = 1:100:length(traj)
diffN = 0;
for i = 2830
    fx = intrinsics(i,3)/7.5;
    fy = intrinsics(i,4)/7.5;
    cx = intrinsics(i,5)/7.5+1;
    cy = intrinsics(i,6)/7.5+1;
    color_pth = path+"/color/"+num2str(intrinsics(i,2))+".png";
    depth_pth = path+"/depth/"+num2str(intrinsics(i,2))+".png";
    imcolor = imread(color_pth);
    imdepth = imread(depth_pth);
    imcolor3col1 = reshape(imcolor,256*192,3);%%256*192
    imdepth = double(imdepth);
%     imdepth = imresize(imdepth,[1440,1920]);

    Z = zeros(192,256);
    step = 1;
    Z(1:step:192,1:step:256) = imdepth(1:step:192,1:step:256);
    Z = Z/1000;
%     Z(Z(:,:)>4.5)=0;
    Z(Z(:,:)<0.25)=0;
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

    T2(1:3,1:3) = quat2rotm([traj(i,8),traj(i,5:7)]);
    T2(1:3,4) =(traj(i,2:4))';
%     T1(1:3,1:3) = quat2rotm([traj(i,5:8)]);
    

    T1(1:3,1:3) = quat2rotm([traj(i+diffN,8),traj(i+diffN,5:7)]);
    T1(1:3,4) =(traj(i+diffN,2:4))';

    
    TT = eye(4);
    TT = inv(T2)*(T1)
    
    RR = TT(1:3,1:3);

    tt = TT(1:3,4);

    xyzPoints1_2c = (R_c2b*(RR*(R_c2b'*xyzPoints'-t_c2b)+tt)+t_c2b)';
%     xyzPoints1_2c = xyzPoints;
    ptCloud1_2c = pointCloud(xyzPoints1_2c, 'Color', imcolor3col1); 
    ptCloud1_2c = pcdenoise(ptCloud1_2c,'NumNeighbors',4,'Threshold',.5);

    ptCloud2 = pcmerge(ptCloud2,ptCloud1_2c,0.001);
end

figure,
pcshow(ptCloud2)
% pcwrite(ptCloud2,'ptCloud2.ply')

i=2830+diffN;
color_pth = path+"/colorRaw/"+num2str(intrinsics(i,2))+".png";
imcolor = imread(color_pth);
imcolor = imresize(imcolor,[480,640]);
fx = intrinsics(i,3)/1920*640;
fy = intrinsics(i,4)/1920*640;
cx = intrinsics(i,5)/1920*640;
cy = intrinsics(i,6)/1920*640;

xyz = ptCloud2.Location;
color = 1.3*ptCloud2.Color;

for i = 1:length(xyz)
    z = xyz(i,3);
    ui = round(fx*xyz(i,1)/z+cx);
    vi = round(fx*xyz(i,2)/z+cy);
%     disp("depth")
%     if(vi<1440&&vi>1&&ui<1920&&ui>1)
    if(vi<480&&vi>2&&ui<640&&ui>2)
%         imcolor(vi,ui,:) = [255,0,0];%color(i,:);
%         imcolor(vi+1,ui+1,:) = [255,0,0];%color(i,:);
%         imcolor(vi-1,ui-1,:) = [255,0,0];%color(i,:);
%         imcolor(vi+1,ui,:) = [255,0,0];%color(i,:);
%         imcolor(vi,ui+1,:) = [255,0,0];%color(i,:);     
        imcolor(vi,ui,:) = color(i,:);%[255,0,0];%color(i,:);
        
%         imcolor(vi+1,ui+1,:) = color(i,:);%[255,0,0];%color(i,:);
%         imcolor(vi+1,ui-1,:) = color(i,:);%[255,0,0];%color(i,:);
        imcolor(vi+1,ui,:) = color(i,:);%[255,0,0];%color(i,:);
        
%         imcolor(vi-1,ui+1,:) = color(i,:);%[255,0,0];%color(i,:);
        imcolor(vi-1,ui,:) = color(i,:);%[255,0,0];%color(i,:);
%         imcolor(vi-1,ui-1,:) = color(i,:);%[255,0,0];%color(i,:);
        
        imcolor(vi,ui-1,:) = color(i,:);%[255,0,0];%color(i,:);
        imcolor(vi,ui+1,:) = color(i,:);%[255,0,0];%color(i,:);
        
%         for ww = -2:2
%             for hh = -2:2
%                 imcolor(vi+ww,ui+hh,:) = color(i,:);
%             end
%         end
%         imcolor(vi+2,ui+2,:) = color(i,:);%[255,0,0];%color(i,:);
%         imcolor(vi-2,ui-2,:) = color(i,:);%[255,0,0];%color(i,:);
%         imcolor(vi+2,ui,:) = color(i,:);%[255,0,0];%color(i,:);
%         imcolor(vi,ui+2,:) = color(i,:);%[255,0,0];%color(i,:);
        
        
    else
%         disp([vi,ui])
    end
%     imcolor(vi,ui,:) = [0,0,0];%color(i,:);
end
figure, imshow(imcolor)
%%
accumTform = rigid3d(T2(1:3,1:3)',[0,0,0]);
ptCloud2Aligned = pctransform(ptCloud2, accumTform);
% figure, pcshow(ptCloud2Aligned)

traj_xyz = (R_c2b*(traj(:,2:4)'))';
traj_color = zeros(length(traj_xyz),3);
traj_color(:,1) = 255;
traj_pc = pointCloud(traj_xyz, 'Color', traj_color);
all_pc = pcmerge(traj_pc,ptCloud2Aligned,0.01);
figure, pcshow(all_pc)


gt2 = importdata('/Users/jin/ss_wroma_2020-10-20-21-48-47_tum.tum');
traj_xyz = (R_c2b*(gt2(:,2:4)'))';
traj_color = zeros(length(traj_xyz),3);
traj_color(:,2) = 255;
traj_pc = pointCloud(traj_xyz, 'Color', traj_color);
all_pc_2 = pcmerge(all_pc,traj_pc,0.01);
figure, pcshow(all_pc_2)