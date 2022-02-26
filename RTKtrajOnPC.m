pc=pcread("/Users/jin/cccc/cloudGlobal.pcd");
lidar_surround = importdata("/Users/jin/cccc/LVI_SAM_key.tum");
rtk = importdata("/Users/jin/cccc/xyz_enu.tum");

pc.Intensity=[];
xyzPoints = pc.Location;
% xyzPoints(xyzPoints(:,3)>1,:) = [];
ptCloud = pointCloud(xyzPoints);
% ptCloud = pcdenoise(ptCloud);
figure,
pcshow(ptCloud)


hold on ,P1= plot3(lidar_surround(:,2),lidar_surround(:,3),lidar_surround(:,4),'m','LineWidth',2);
hold on 
plot3(lidar_surround(:,2),lidar_surround(:,3),lidar_surround(:,4),'m.','LineWidth',5,'MarkerSize',10);
hold on 
plot3(lidar_surround(1,2),lidar_surround(1,3),lidar_surround(1,4),'m*','LineWidth',5,'MarkerSize',15);
hold on 
plot3(lidar_surround(end,2),lidar_surround(end,3),lidar_surround(end,4),'mx','LineWidth',5,'MarkerSize',15);


hold on ,P2= plot3(rtk(:,2),rtk(:,3),rtk(:,4),'g','LineWidth',2);
hold on ,plot3(rtk(:,2),rtk(:,3),rtk(:,4),'g.','LineWidth',5,'MarkerSize',10);
hold on ,plot3(rtk(1,2),rtk(1,3),rtk(1,4),'g*','LineWidth',5,'MarkerSize',15);
hold on ,plot3(rtk(end,2),rtk(end,3),rtk(end,4),'gx','LineWidth',5,'MarkerSize',15);
lgnd = legend([P1 P2],{'LVI-SAM','RTK'},'FontSize',30);
set(lgnd,'color','w');

set(gcf,'color','w');
set(gca,'color','w');
grid minor
set(gca,'FontSize',30)
set(gca,'LineWidth',5) 