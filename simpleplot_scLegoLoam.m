lidar_path = importdata("/Users/jin/Desktop/lidar_traj/2021-10-26-14-09-57.txt");

h = figure('units','normalized','outerposition',[0 0 1 1]);

subplot(1,2,1)
plot(lidar_path(:,2),lidar_path(:,4),'b','LineWidth',3);
grid minor
axis equal
set(gcf,'color','w');
set(gca,'color','w');
set(gca,'FontSize',20,'FontWeight','bold')

xlabel("X (m)",'FontSize',20,'FontWeight','bold');
ylabel("Z (m)",'FontSize',20,'FontWeight','bold');
title("04 island B VLP16 loop",'FontSize',30,'FontWeight','bold')

subplot(1,2,2)
plot(lidar_path(:,2),lidar_path(:,3),'b','LineWidth',3);
grid minor
axis equal
set(gcf,'color','w');
set(gca,'color','w');
set(gca,'FontSize',20,'FontWeight','bold')

xlabel("X (m)",'FontSize',20,'FontWeight','bold');
ylabel("Y (m)",'FontSize',20,'FontWeight','bold');
title("SC Lego LOAM",'FontSize',30,'FontWeight','bold')

exportgraphics(h,"/Users/jin/Desktop/lidar_traj/04island_B_VLP16_loop_2021-10-26-14-09-57.png");