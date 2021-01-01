% ddd1=importdata("/Users/jin/Downloads/ipad/02_08/ARposes.txt");
ddd1=importdata("/Volumes/BlackSSD/OBS/l515_gt.csv");
% ddd1=importdata("/Volumes/BlackSSD/ss2/comp/div/faceNearLong_est.csv");
% ddd1=importdata("/Volumes/BlackSSD/ss2/comp/div/faceFarshort_est.csv");
% ddd1=importdata("/Volumes/BlackSSD/ss2/comp/div/faceFarLong_est.csv");

% ddd1 = ddd1(9009:15828,:);
ddd1(:,1) = ddd1(:,1) - ddd1(1,1);
% figure,plot3(ddd1(:,2),ddd1(:,3),ddd1(:,4),'b','LineWidth',2),axis equal,grid minor
%%
figure,patch(ddd1(:,2),ddd1(:,3),ddd1(:,4),ddd1(:,1),'edgecolor','flat','facecolor','none','LineWidth',3)
grid minor
view(3);colorbar
axis equal
set(gcf,'color','w');


xlabel("X (m)",'FontSize',20,'FontWeight','bold');
ylabel("Y (m)",'FontSize',20,'FontWeight','bold');
zlabel("Z (m)",'FontSize',20,'FontWeight','bold');

view(0,0)

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