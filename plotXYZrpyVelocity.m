close all
clear
clc
vins = importdata('/Users/jin/Q_Mac/data/temp/4min/result/rgbd640_dist0.2/rgbd_vio_vins_cp.csv');
% vins = vins(1:5:135,:);
gt = importdata('/Users/jin/Q_Mac/data/temp/4min/groundtruth/gt_cp/4min_gt_cp.csv'); 



% gt(:,1) = gt(:,1) - 0.0458;
gt = gt(gt(:,1)<max((vins(:,1)+.5)),:);
% gt = gt(1:1080,:);
% gt = gt(1:8:end,:);

A = repmat(gt(:,1),[1 length(vins(:,1))]);
[minValue,closestIndex] = min(abs(A-vins(:,1)'));

closestValue = gt(closestIndex,1);
%%
rpy_vins = quat2eul([vins(:,8),vins(:,5:7)])*180/pi;
rpy_gt = quat2eul([gt(:,8),gt(:,5:7)])*180/pi;


rpy_vins = [vins(:,1),rpy_vins];
rpy_gt = [gt(:,1),rpy_gt];
% rpy_oldgt = [oldgt(:,1),rpy_oldgt];


rpy_gt(rpy_gt(:,1)<50&rpy_gt(:,4)<-50,4) = rpy_gt(rpy_gt(:,1)<50&rpy_gt(:,4)<-50,4)+360;
rpy_gt(rpy_gt(:,1)<95&rpy_gt(:,1)>85&rpy_gt(:,4)>0,4) = rpy_gt(rpy_gt(:,1)<95&rpy_gt(:,1)>85&rpy_gt(:,4)>0,4)-360;
% [24021;21207;17766;8045]
L = length(rpy_gt);
rpy_gt(8485:L,4)=rpy_gt(8485:L,4)+360;
rpy_gt(17766:L,4)=rpy_gt(17766:L,4)+360;
rpy_gt(21207:L,4)=rpy_gt(21207:L,4)+360;
rpy_gt(24021:L,4)=rpy_gt(24021:L,4)+360;



rpy_vins(rpy_vins(:,1)<40&rpy_vins(:,1)>20&rpy_vins(:,4)<-0,4) = rpy_vins(rpy_vins(:,1)<40&rpy_vins(:,1)>20&rpy_vins(:,4)<-0,4)+360;
rpy_vins(rpy_vins(:,1)<90&rpy_vins(:,1)>65&rpy_vins(:,4)<-0,4) = rpy_vins(rpy_vins(:,1)<90&rpy_vins(:,1)>65&rpy_vins(:,4)<-0,4)+360;
% [1670;1547;959]
rpy_vins(960:1547,4)=rpy_vins(960:1547,4)+360;
rpy_vins(1548:1670,4)=rpy_vins(1548:1670,4)+360+360;
% figure
% subplot(3,1,1)
% plot(rpy_vins(:,1),rpy_vins(:,2),'g'),grid minor
% subplot(3,1,2)
% plot(rpy_vins(:,1),rpy_vins(:,3),'g'),grid minor
% subplot(3,1,3)
% plot(rpy_vins(:,1),rpy_vins(:,4),'g'),grid minor
% 
% figure
% subplot(3,1,1)
% plot(rpy_gt(:,1),rpy_gt(:,2),'g'),grid minor
% subplot(3,1,2)
% plot(rpy_gt(:,1),rpy_gt(:,3),'g'),grid minor
% subplot(3,1,3)
% plot(rpy_gt(:,1),rpy_gt(:,4),'g'),grid minor


%%
labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);
% h =figure();
% set(h, 'position', [10, 10, 1500, 900]);

% set(gcf,'position',[10, 10, 1500, 900])

subplot(3,1,1)
plot(rpy_vins(:,1),rpy_vins(:,2),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt(:,1),rpy_gt(:,2),'b','LineWidth',2)

title("Roll",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Angle (degree)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth")
    
subplot(3,1,2)
plot(rpy_vins(:,1),rpy_vins(:,3),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt(:,1),rpy_gt(:,3),'b','LineWidth',2)
title("Pitch",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Angle (degree)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth")

subplot(3,1,3)
plot(rpy_vins(:,1),rpy_vins(:,4),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt(:,1),rpy_gt(:,4),'b','LineWidth',2)
title("Yaw",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Angle (degree)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'angle.png') 

%%
labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

A = repmat(gt(:,1),[1 length(vins(:,1))]);
[minValue,closestIndex] = min(abs(A-vins(:,1)'));

subplot(3,1,1)
plot(rpy_vins(:,1),rpy_vins(:,2),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt(closestIndex,1),rpy_gt(closestIndex,2),'b','LineWidth',2)

title("Roll",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Angle (degree)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth")
    
subplot(3,1,2)
plot(rpy_vins(:,1),rpy_vins(:,3),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt(closestIndex,1),rpy_gt(closestIndex,3),'b','LineWidth',2)
title("Pitch",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Angle (degree)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth")

subplot(3,1,3)
plot(rpy_vins(:,1),rpy_vins(:,4),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt(closestIndex,1),rpy_gt(closestIndex,4),'b','LineWidth',2)
title("Yaw",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Angle (degree)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'angle_closet.png') 
%%
mean(abs(rpy_vins(:,1)-rpy_gt(closestIndex,1)))
mean(abs(rpy_vins(:,2)-rpy_gt(closestIndex,2)))
mean(abs(rpy_vins(:,3)-rpy_gt(closestIndex,3)))
mean(abs(rpy_vins(:,4)-rpy_gt(closestIndex,4)))

std(abs(rpy_vins(:,2)-rpy_gt(closestIndex,2)))
std(abs(rpy_vins(:,3)-rpy_gt(closestIndex,3)))
std(abs(rpy_vins(:,4)-rpy_gt(closestIndex,4)))
%%

labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);


subplot(3,1,1)
plot(vins(:,1),vins(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt(:,1),gt(:,2),'b','LineWidth',2)

title("X",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Position (m)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(vins(:,1),vins(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt(:,1),gt(:,3),'b','LineWidth',2)
title("Y",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Position (m)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

subplot(3,1,3)
plot(vins(:,1),vins(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt(:,1),gt(:,4),'b','LineWidth',2)
title("Z",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Position (m)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'xyz.png') 

%%
A = repmat(gt(:,1),[1 length(vins(:,1))]);
[minValue,closestIndex] = min(abs(A-vins(:,1)'));

labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);


subplot(3,1,1)
plot(vins(:,1),vins(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt(closestIndex,1),gt(closestIndex,2),'b','LineWidth',2)

title("X",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Position (m)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(vins(:,1),vins(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt(closestIndex,1),gt(closestIndex,3),'b','LineWidth',2)
title("Y",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Position (m)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

subplot(3,1,3)
plot(vins(:,1),vins(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt(closestIndex,1),gt(closestIndex,4),'b','LineWidth',2)
title("Z",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Position (m)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'xyz_closest.png') 
%%
% mean(abs(vins(:,1)-gt(closestIndex,1)))
mean(abs(vins(:,2)-gt(closestIndex,2)))
mean(abs(vins(:,3)-gt(closestIndex,3)))
mean(abs(vins(:,4)-gt(closestIndex,4)))

% std(abs(vins(:,1)-gt(closestIndex,1)))
std(abs(vins(:,2)-gt(closestIndex,2)))
std(abs(vins(:,3)-gt(closestIndex,3)))
std(abs(vins(:,4)-gt(closestIndex,4)))
%%
Lvins = length(vins);
vins_Vxyz(:,1) = (vins(2:Lvins,1)+vins(1:Lvins-1,1))/2;
vins_Vxyz(:,2:4) = (vins(2:Lvins,2:4)-vins(1:Lvins-1,2:4))./(vins(2:Lvins,1)-vins(1:Lvins-1,1));

Lgt = length(gt);
gt_Vxyz(:,1) = (gt(2:Lgt,1)+gt(1:Lgt-1,1))/2;
gt_Vxyz(:,2:4) = (gt(2:Lgt,2:4)-gt(1:Lgt-1,2:4))./(gt(2:Lgt,1)-gt(1:Lgt-1,1));


labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(vins_Vxyz(:,1),vins_Vxyz(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,2),'b','LineWidth',2)

title("Vx",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Velocity (m/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','northeast')
    
subplot(3,1,2)
plot(vins_Vxyz(:,1),vins_Vxyz(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,3),'b','LineWidth',2)
title("Vy",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Velocity (m/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

subplot(3,1,3)
plot(vins_Vxyz(:,1),vins_Vxyz(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,4),'b','LineWidth',2)
title("Vz",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Velocity (m/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'Vxyz.png') 
%%
Lvins = length(vins);
vins_Vxyz(:,1) = (vins(2:Lvins,1)+vins(1:Lvins-1,1))/2;
vins_Vxyz(:,2:4) = (vins(2:Lvins,2:4)-vins(1:Lvins-1,2:4))./(vins(2:Lvins,1)-vins(1:Lvins-1,1));

Lgt = length(gt);
gt_Vxyz(:,1) = (gt(2:Lgt,1)+gt(1:Lgt-1,1))/2;
gt_Vxyz(:,2:4) = (gt(2:Lgt,2:4)-gt(1:Lgt-1,2:4))./(gt(2:Lgt,1)-gt(1:Lgt-1,1));

A = repmat(rpy_gt(:,1),[1 length(vins_Vxyz(:,1))]);
[minValue,closestIndex] = min(abs(A-vins_Vxyz(:,1)'));
gt_Vxyz_ds = gt_Vxyz(closestIndex,:);

labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(vins_Vxyz(:,1),vins_Vxyz(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz_ds(:,1),gt_Vxyz_ds(:,2),'b','LineWidth',2)

title("Vx",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Velocity (m/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','northeast')
    
subplot(3,1,2)
plot(vins_Vxyz(:,1),vins_Vxyz(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz_ds(:,1),gt_Vxyz_ds(:,3),'b','LineWidth',2)
title("Vy",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Velocity (m/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

subplot(3,1,3)
plot(vins_Vxyz(:,1),vins_Vxyz(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz_ds(:,1),gt_Vxyz_ds(:,4),'b','LineWidth',2)
title("Vz",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel("Velocity (m/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'Vxyz_closest.png') 
%%
clc
mean(abs(vins_Vxyz(:,1)-gt_Vxyz_ds(:,1)))
mean(abs(vins_Vxyz(:,2)-gt_Vxyz_ds(:,2)))
mean(abs(vins_Vxyz(:,3)-gt_Vxyz_ds(:,3)))
mean(abs(vins_Vxyz(:,4)-gt_Vxyz_ds(:,4)))

std(abs(vins_Vxyz(:,2)-gt_Vxyz_ds(:,2)))
std(abs(vins_Vxyz(:,3)-gt_Vxyz_ds(:,3)))
std(abs(vins_Vxyz(:,4)-gt_Vxyz_ds(:,4)))
%%
Lvins = length(rpy_vins);
vins_Vrpy(:,1) = (rpy_vins(2:Lvins,1)+rpy_vins(1:Lvins-1,1))/2;
vins_Vrpy(:,2:4) = (rpy_vins(2:Lvins,2:4)-rpy_vins(1:Lvins-1,2:4))./(rpy_vins(2:Lvins,1)-rpy_vins(1:Lvins-1,1));

Lgt = length(rpy_gt);
clear gt_Vrpy
gt_Vrpy(:,1) = (rpy_gt(2:Lgt,1)+rpy_gt(1:Lgt-1,1))/2;
gt_Vrpy(:,2:4) = (rpy_gt(2:Lgt,2:4)-rpy_gt(1:Lgt-1,2:4))./(rpy_gt(2:Lgt,1)-rpy_gt(1:Lgt-1,1));


labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(gt_Vrpy(:,1),gt_Vrpy(:,2),'b','LineWidth',2)
grid minor,hold on
plot(vins_Vrpy(:,1),vins_Vrpy(:,2),'r','LineWidth',2)
title("Wroll",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(gt_Vrpy(:,1),gt_Vrpy(:,3),'b','LineWidth',2)
grid minor,hold on
plot(vins_Vrpy(:,1),vins_Vrpy(:,3),'r','LineWidth',2)
title("Wpitch",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

subplot(3,1,3)
plot(gt_Vrpy(:,1),gt_Vrpy(:,4),'b','LineWidth',2)
grid minor,hold on
plot(vins_Vrpy(:,1),vins_Vrpy(:,4),'r','LineWidth',2)
title("Wyaw",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'Wrpy.png') 
%%
Lvins = length(rpy_vins);
vins_Vrpy(:,1) = (rpy_vins(2:Lvins,1)+rpy_vins(1:Lvins-1,1))/2;
vins_Vrpy(:,2:4) = (rpy_vins(2:Lvins,2:4)-rpy_vins(1:Lvins-1,2:4))./(rpy_vins(2:Lvins,1)-rpy_vins(1:Lvins-1,1));

Lgt = length(rpy_gt);
clear gt_Vrpy
gt_Vrpy(:,1) = (rpy_gt(2:Lgt,1)+rpy_gt(1:Lgt-1,1))/2;
gt_Vrpy(:,2:4) = (rpy_gt(2:Lgt,2:4)-rpy_gt(1:Lgt-1,2:4))./(rpy_gt(2:Lgt,1)-rpy_gt(1:Lgt-1,1));


A = repmat(rpy_gt(:,1),[1 length(vins_Vrpy(:,1))]);
[minValue,closestIndex] = min(abs(A-vins_Vrpy(:,1)'));
gt_Vrpy_ds = gt_Vrpy(closestIndex,:);

labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(gt_Vrpy_ds(:,1),gt_Vrpy_ds(:,2),'b','LineWidth',2)
grid minor,hold on
plot(vins_Vrpy(:,1),vins_Vrpy(:,2),'r','LineWidth',2)
title("Wroll",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(gt_Vrpy_ds(:,1),gt_Vrpy_ds(:,3),'b','LineWidth',2)
grid minor,hold on
plot(vins_Vrpy(:,1),vins_Vrpy(:,3),'r','LineWidth',2)
title("Wpitch",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

subplot(3,1,3)
plot(gt_Vrpy_ds(:,1),gt_Vrpy_ds(:,4),'b','LineWidth',2)
grid minor,hold on
plot(vins_Vrpy(:,1),vins_Vrpy(:,4),'r','LineWidth',2)
title("Wyaw",'FontSize',titleszie)
xlabel("time (s)",'FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'Wrpy_closest.png') 
%%
mean(abs(vins_Vrpy(:,1)-gt_Vrpy_ds(:,1)))
mean(abs(vins_Vrpy(:,2)-gt_Vrpy_ds(:,2)))
mean(abs(vins_Vrpy(:,3)-gt_Vrpy_ds(:,3)))
mean(abs(vins_Vrpy(:,4)-gt_Vrpy_ds(:,4)))

std(abs(vins_Vrpy(:,2)-gt_Vrpy_ds(:,2)))
std(abs(vins_Vrpy(:,3)-gt_Vrpy_ds(:,3)))
std(abs(vins_Vrpy(:,4)-gt_Vrpy_ds(:,4)))
%%
trj = vins;
L = length(trj);
r_xyz = zeros(L-1,3);
r_rpy = zeros(L-1,3);
for i = 1:L-1
    T1= eye(4);
    T2= eye(4);
    T1(1:3,1:3) = quat2rotm([trj(i,8),trj(i,5:7)]);
    T1(1:3,4) =(trj(i,2:4))';
    T2(1:3,1:3) = quat2rotm([trj(i+1,8),trj(i+1,5:7)]);
    T2(1:3,4) =(trj(i+1,2:4))';
    T12 = T1\T2;
    r_xyz(i,:) = T12(1:3,4);
    r_rpy(i,:) = rotm2eul(T12(1:3,1:3))*180/pi;
end

r_vins = [vins(2:L,1),r_xyz];
r_vinsEul = [vins(2:L,1),r_rpy];
%%
A = repmat(gt(:,1),[1 length(vins(:,1))]);
[minValue,closestIndex] = min(abs(A-vins(:,1)'));
trj = gt(closestIndex,:);
L = length(trj);
r_xyz = zeros(L-1,3);
r_rpy = zeros(L-1,3);
for i = 1:L-1
    T1= eye(4);
    T2= eye(4);
    T1(1:3,1:3) = quat2rotm([trj(i,8),trj(i,5:7)]);
    T1(1:3,4) =(trj(i,2:4))';
    T2(1:3,1:3) = quat2rotm([trj(i+1,8),trj(i+1,5:7)]);
    T2(1:3,4) =(trj(i+1,2:4))';
    T12 = T1\T2;
    r_xyz(i,:) = T12(1:3,4);
    r_rpy(i,:) = rotm2eul(T12(1:3,1:3))*180/pi;
end

r_gt = [trj(2:L,1),r_xyz];
r_gtEul = [trj(2:L,1),r_rpy];
%%
mean( abs((r_vinsEul(:,2)-r_gtEul(:,2))) )
mean( abs((r_vinsEul(:,3)-r_gtEul(:,3))) )
mean( abs((r_vinsEul(:,4)-r_gtEul(:,4))) )

std( abs((r_vinsEul(:,2)-r_gtEul(:,2))) )
std( abs((r_vinsEul(:,3)-r_gtEul(:,3))) )
std( abs((r_vinsEul(:,4)-r_gtEul(:,4))) )
