l515 = importdata("/Users/jin/Desktop/checkLT/imu_l515.txt");
t265 = importdata("/Users/jin/Desktop/checkLT/imu_t265.txt"); 
d_t = +0.045;
figure,
pt1= plot(l515(:,1)+d_t,vecnorm(l515(:,2:4)'),'r');
hold on
pt2 = plot(t265(:,1),vecnorm(t265(:,2:4)'),'b--');

legend([pt1 pt2],{'l515','t265'},'FontSize',30)

grid minor

xlabel("timestamp",'FontSize',30,'FontWeight','bold')
ylabel("acc norm",'FontSize',30,'FontWeight','bold');

set(gca,'FontSize',30)
set(gcf,'color','w');

figure,
pt1= plot(l515(:,1)+d_t,vecnorm(l515(:,5:7)'),'r');
hold on
pt2 = plot(t265(:,1),vecnorm(t265(:,5:7)'),'b--');
legend([pt1 pt2],{'l515','t265'},'FontSize',30)

grid minor

xlabel("timestamp",'FontSize',30,'FontWeight','bold')
ylabel("gyro norm",'FontSize',30,'FontWeight','bold');

set(gca,'FontSize',30)
set(gcf,'color','w');