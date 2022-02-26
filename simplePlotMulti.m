lidar_surround = importdata("/Users/jin/Desktop/Results/LVI_SAM_key.tum");
rtk_xy=importdata("/Users/jin/Desktop/Results/vins_result_loopMod3.tum");
plot(rtk_xy(:,2),rtk_xy(:,3),'r','LineWidth',3);
hold on
plot(lidar_surround(:,2),lidar_surround(:,3),'g:','LineWidth',3);


hold on
plot(rtk_xy(:,2),rtk_xy(:,3),'rX','LineWidth',3,'MarkerSize',4);
hold on
plot(lidar_surround(:,2),lidar_surround(:,3),'gX','LineWidth',3,'MarkerSize',4);

% hold on
% plot(rtk_xy(:,3),rtk_xy(:,2),'mX','LineWidth',3,'MarkerSize',4);
% hold on
% plot(t265_top(:,3),t265_top(:,2),'LineWidth',3);
grid minor

axis equal
% view(0,90)
set(gcf,'color','w');
set(gca,'color','w');
% ylim([-20,20])
xlabel("Y (m)",'FontSize',20,'FontWeight','bold');
ylabel("X (m)",'FontSize',20,'FontWeight','bold');
set(gca,'LineWidth',3) 
set(gca,'FontSize',20)
legend({'VINS modified loop 1.15 scale','GT (LVI-SAM)'},'FontSize',30)