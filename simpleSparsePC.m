clear all
clc

frames = importdata("/Users/jin/Q_Mac/data/testMoving/2020-12-06T14-23-35/Frames.txt");
pt3d = importdata("/Users/jin/Q_Mac/data/testMoving/2020-12-06T14-23-35/ARpds.txt");
pose3d = importdata("/Users/jin/Q_Mac/data/testMoving/2020-12-06T14-23-35/ARposes.txt");

count = 0;
pc_color = []
for i = 1:1:2700
    i
    dir_name = "/Users/jin/Q_Mac/data/testMoving/2020-12-06T14-23-35/color/"+num2str(i)+".png";
    img = imread(dir_name);
    idx_pts = find(pt3d(:,1)==frames(i,1));
    idx_pos = find(pose3d(:,1)==frames(i,1));
    T = eye(4);
    T(1:3,4) = pose3d(idx_pos,2:4);
    T(1:3,1:3) = quat2rotm (pose3d(idx_pos,5:8));
    for j = idx_pts'
        pt_word = [pt3d(j,2),pt3d(j,3),pt3d(j,4),1];
        pt_local = inv(T)*pt_word';
        
        xx = round(pt_local(1)*1460.530884/pt_local(3)+957.091064);
        yy = round(pt_local(2)*1460.530884/pt_local(3)+656.016968);
        
        if(xx<1920&&xx>0&&yy>0&&yy<1440)
            ptcolor = double(img(yy,xx,:));
            count = count+1;
            pc_color = [pc_color;pt3d(j,2:4),ptcolor(:)'];
        end
    
%         pc_color = [pc_color;pt3d(j,2:4)];
    end

    
end

ptCloud = pointCloud(pc_color(:,1:3),'Color',uint8(pc_color(:,4:6)));
figure,pcshow(ptCloud)

% pcwrite(ptCloud,"/Users/jin/Q_Mac/data/testMoving/2020-12-06T14-23-35/pc.pcd");
% %%
% 
% pc = pcread("/Users/jin/Q_Mac/data/testMoving/2020-12-06T14-23-35/pc.pcd");
% figure,pcshow(pc)