close all
clear
clc


V1 = [
          1631260316.29595
          1631260419.82922
          1631260453.69563
           1631260491.7613
          1631260522.89442
          1631260601.62575
          1631260669.15833
           1631260771.6918
          1631260806.42443
          1631261016.22201
          1631261046.28814
          1631261124.75244
];

V2 = [
          1631262620.61966
          1631262703.88533
          1631262735.08325
          1631262792.81593
          1631262828.94769
          1631262934.34241
          1631263110.80547
          1631263191.47177
          1631263223.00374
          1631263398.20003
          1631263434.59908
          1631263541.25967
];

V3 = [
          1631263672.82537
          1631263750.25946
           1631263781.8265
          1631263829.42823
          1631263866.96227
           1631263973.4599
           1631264064.8303
           1631264144.2667
          1631264175.83274
          1631264347.23404
          1631264383.30071
          1631264489.09445
];

V = V1;
traj = importdata("/Users/jin/Downloads/vioPath/1/vio_loop.csv");
figure,plot3(traj(:,2),traj(:,3),traj(:,4),'LineWidth',3)
title("data1")
N = traj(:,1);
 
A = repmat(N,[1 length(V)]);
[minValue,closestIndex] = min(abs(A-V'));


hold on 
plot3(traj(closestIndex(1:6),2),traj(closestIndex(1:6),3),traj(closestIndex(1:6),4),'r*','LineWidth',3);
hold on 
plot3(traj(closestIndex(6:12),2),traj(closestIndex(6:12),3),traj(closestIndex(6:12),4),'go','MarkerSize',10,'LineWidth',3);

hold on
plot3(traj(closestIndex(1),2),traj(closestIndex(1),3),traj(closestIndex(1),4),'kx','MarkerSize',10,'LineWidth',4);
hold on 
plot3(traj(closestIndex(12),2),traj(closestIndex(12),3),traj(closestIndex(12),4),'kx','MarkerSize',10,'LineWidth',4);

axis equal
grid minor
%

gt = [25,9.9,11.7,11.4,36.2,0.65,25,9.9,11.7,11.4,36.2,0.65];
dist = vecnorm((traj(closestIndex([2:12,1]),2:4)-traj(closestIndex(1:12),2:4))')

% percetage = dist./gt