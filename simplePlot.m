clc
cursor_info.Position(1)
%%
clear
close all

format long g

% ddd1=importdata("/Users/jin/Downloads/ipad/02_08/ARposes.txt");
ddd1=importdata("/Volumes/Dreame/Dreame/data/Dreame_data/8_26_t265data_second/accData.txt");

ddd2=importdata("/Volumes/Dreame/Dreame/data/Dreame_data/8_26_t265data_second/imu0.log");


figure,
subplot(3,1,1)
plot(ddd1(:,1)/1e9,ddd1(:,2),'g')
hold on 
plot(ddd2(:,1),ddd2(:,2),'r--'),grid minor

subplot(3,1,2)
plot(ddd1(:,1)/1e9,ddd1(:,3),'g')
hold on 
plot(ddd2(:,1),ddd2(:,3),'r--'),grid minor

subplot(3,1,3)
plot(ddd1(:,1)/1e9,ddd1(:,4),'g')
hold on 
plot(ddd2(:,1),ddd2(:,4),'r--'),grid minor
%%


idx = 1742;
% ddd1=importdata("/Users/jin/Q_Mac/localdata/ip12_150m/results/vins_result_loop.csv");idx = 123;
% ddd1=importdata("/Users/jin/Q_Mac/localdata/ip12_150m/results/vins_result_no_loop.csv");idx = 286;
% ddd1=importdata("/Users/jin/Q_Mac/localdata/ip12_150m/results/rgbd_vio.csv");idx = 264;
% ddd1=importdata("/Users/jin/Q_Mac/localdata/ip12_150m/results/rgbd_vio_intrinsic.csv");idx = 287;
% ddd1=importdata("/Users/jin/Q_Mac/localdata/ip12_150m/results/rgbd_vio4.csv");idx = 287;
%
% ddd1 = ddd1(9009:15828,:);
ddd1(:,1) = ddd1(:,1) - ddd1(1,1);
% [val,idx] = min(ddd1(1:40*30,3));

figure,plot3(ddd1(:,2),-ddd1(:,3),ddd1(:,4),'b.','LineWidth',1),axis equal,grid minor
hold on, plot3(ddd1(end,2),-ddd1(end,3),ddd1(end,4),'r*','LineWidth',4)
hold on, plot3(ddd1(idx,2),-ddd1(idx,3),ddd1(idx,4),'g*','LineWidth',4)

norm( [ddd1(idx,2),ddd1(idx,3),ddd1(idx,4)] - [ddd1(end,2),ddd1(end,3),ddd1(end,4)] )

%%
hold on 

ddd1=importdata("/Users/jin/Downloads/odom.txt");
% ddd1=importdata("/Volumes/BlackSSD/ss2/comp/div/faceNearLong_est.csv");
% ddd1=importdata("/Volumes/BlackSSD/ss2/comp/div/faceFarshort_est.csv");
% ddd1=importdata("/Volumes/BlackSSD/ss2/comp/div/faceFarLong_est.csv");
%
% ddd1 = ddd1(9009:15828,:);
ddd1(:,1) = ddd1(:,1) - ddd1(1,1);
[val,idx] = min(ddd1(1:30*30,3));
idx = 100;
plot3(ddd1(:,2),-ddd1(:,3),ddd1(:,4),'g.','LineWidth',1),axis equal,grid minor
hold on, plot3(ddd1(end,2),-ddd1(end,3),ddd1(end,4),'r*','LineWidth',4)
hold on, plot3(ddd1(idx,2),-ddd1(idx,3),ddd1(idx,4),'g*','LineWidth',4)

norm( [ddd1(idx,2),ddd1(idx,3),ddd1(idx,4)] - [ddd1(end,2),ddd1(end,3),ddd1(end,4)] )
grid minor
%%
ddd1 = gt;
%%
clear
ddd1 = importdata("/Users/jin/Downloads/odom.txt");
% ddd1(:,1) = ddd1(:,1)-ddd1(1,1);
% ddd1 = ddd1(1:3720,:);
% ddd1 = ddd1(3720:end,:);
figure ,patch(ddd1(:,2),ddd1(:,4),ddd1(:,3),(ddd1(:,1)-ddd1(1,1)),'edgecolor','flat','facecolor','none','LineWidth',3)
% figure,plot3(ddd1(:,2),-ddd1(:,3),ddd1(:,4),'b','LineWidth',3)
% ylim([-35,10])
grid minor
view(3);colorbar
axis equal
set(gcf,'color','w');

% hold on, plot3(ddd1(end,2),ddd1(end,3),ddd1(end,4),'b*','LineWidth',7)
% hold on, plot3(ddd1(1,2),ddd1(1,3),ddd1(1,4),'r*','LineWidth',7)

xlabel("X (m)",'FontSize',20,'FontWeight','bold');
ylabel("Y (m)",'FontSize',20,'FontWeight','bold');
zlabel("Z (m)",'FontSize',20,'FontWeight','bold');

% view(0,0)

%%

ddd1= importdata("/Users/jin/Q_Mac/work/temp/gt/corridor4_gt.csv");
%%
figure,
tt = [1608253959.648755813
1608253704.216312740
1608253716.129180692
1608253730.251878317
1608253750.800028766
1608253754.165118559
1608253756.574948623
1608253762.937677485
1608253776.513559793
1608253796.586448715
1608253810.701120022
1608253831.548367881
1608253850.604920184
1608253862.434468465
1608253880.664168662
1608253889.200758241
1608253894.898903038
1608253914.460398690
1608253928.058058687
1608253954.120840964
1608253957.495070945
1608253958.157157990];
subplot(4,1,1)
plot(ddd1(:,1),ddd1(:,2),'g'),grid minor
hold on,plot(tt(:,1),0*ones(length(tt),1),'ro'),grid minor

subplot(4,1,2)
plot(ddd1(:,1),ddd1(:,3),'g'),grid minor
hold on,plot(tt(:,1),0*ones(length(tt),1),'ro'),grid minor

subplot(4,1,3)
plot(ddd1(:,1),ddd1(:,4),'g'),grid minor
hold on,plot(tt(:,1),0*ones(length(tt),1),'ro'),grid minor

axang = quat2axang([ddd1(:,8),ddd1(:,5:7)])*180/pi;
subplot(4,1,4)
plot(ddd1(:,1),axang(:,4),'g'),grid minor
hold on,plot(tt(:,1),0*ones(length(tt),1),'ro'),grid minor
%%
figure,
eulr = quat2eul(ddd1(:,5:8))*180/pi;
subplot(3,1,1)
plot(ddd1(:,1),eulr(:,1),'g'),grid minor


subplot(3,1,2)
plot(ddd1(:,1),eulr(:,2),'g'),grid minor
% 

subplot(3,1,3)
plot(ddd1(:,1),eulr(:,3),'g'),grid minor
% 

%%
axis_angle = quat2axang(ddd1(:,5:8));
figure,
plot(ddd1(:,1),axis_angle(:,4),'g'),grid minor
%%
% clc
A = cursor_info1(4).Position;
B = cursor_info1(3).Position;
C = cursor_info1(2).Position;
D = cursor_info1(1).Position;
% E = cursor_info9(5).Position;
norm(A-B)
norm(B-C)
norm(C-D)
norm(D-A)
% norm(D-E)
% norm(A-E)
% norm(D-A)