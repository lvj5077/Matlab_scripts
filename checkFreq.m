dt = importdata("/Volumes/Dreame/iphoneLong/2021-09-13T19-14-19/imu_vn100.log");
dt(:,1) = dt(:,1);
d_length = length(dt);
(dt(end,1) - dt(1,1))/60

plot(1./ (dt(12:d_length,1)-dt(11:d_length-1,1)))
title("Image Frequency")
grid minor


%%
figure,
imu_data = importdata("/Volumes/Dreame/Dreame/data/Dreame_data/9_10/dataset_0910/3/imu0.log");

subplot(6,1,1),plot(imu_data(:,1),imu_data(:,2));
subplot(6,1,2),plot(imu_data(:,1),imu_data(:,3));
subplot(6,1,3),plot(imu_data(:,1),imu_data(:,4))
subplot(6,1,4),plot(imu_data(:,1),imu_data(:,5));
subplot(6,1,5),plot(imu_data(:,1),imu_data(:,6));
subplot(6,1,6),plot(imu_data(:,1),imu_data(:,7))