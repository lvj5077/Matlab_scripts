plot(imu_data(:,1)-imu_data(1,1),vecnorm(imu_data(:,2:4)'));
hold on 
pt2 = plot(imu_data(:,1)-imu_data(1,1),9.8*ones(length(imu_data),1),'r','LineWidth',2);
grid minor
ylim([8,12])
title("IMU norm",'FontSize',20)
xlabel("t (s)",'FontSize',20,'FontWeight','bold')
ylabel("m/s^2",'FontSize',20,'FontWeight','bold')

legend(pt2, "9.8 m/s2")
%%

ddd = importdata("/Users/jin/bias.txt");
figure,
plot(imu_data(:,1)-imu_data(1,1),vecnorm(imu_data(:,2:4)')-9.8);
hold on ,plot(ddd(:,1)-ddd(1,1),-vecnorm(ddd(:,2:4)'));