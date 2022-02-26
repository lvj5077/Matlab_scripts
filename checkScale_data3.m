close all
clear
traj = importdata("/Volumes/Dreame/Dreame/data/Dreame_data/9_10/dataset_0910/3/traj/orb3/CameraTrajectory.txt");
% traj = importdata("/Volumes/Dreame/Dreame/data/Dreame_data/9_10/dataset_0910/3/traj/orb3/CameraTrajectory.txt");
% traj = importdata("/Users/jin/data3_VF_mei_org/vio.csv");

% traj1 = traj(1:3000,:);
% traj1 = traj(5200:9860,:);
traj1  = traj;
plot3(traj1(:,2),traj1(:,3),traj1(:,4),'LineWidth',3)


V = [
1631263672.82537
1631263750.25946
1631263781.8265
1631263829.42823
1631263866.96227
1631263973.4599
1631264064.8303
% %
% 1631264065.3303
1631264144.2667
1631264175.83274
1631264347.23404
1631264383.30071
1631264489.09445
];
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
dist = vecnorm((traj(closestIndex([2:12,1]),2:4)-traj(closestIndex(1:12),2:4))');

dist./gt