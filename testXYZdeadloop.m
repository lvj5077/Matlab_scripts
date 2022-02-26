close all
clear

d = importdata('/Users/lingqiujin/Data/iphone7_06_04_2019/vins/XYZ.txt'); 
plot3(d(1:end,1),d(1:end,2),d(1:end,3),'b','LineWidth',3);
norm([d(end,1),d(end,2),d(end,3)])
d = importdata('/Users/lingqiujin/Data/iphone7_06_04_2019/vins/vins_result_no_loop.csv');

% plot3(d(:,2),d(:,3),d(:,4),'g','LineWidth',3);
% plot3(d(990:end-90,1),d(990:end-90,2),d(990:end-90,3),'b','LineWidth',3); grid minor
d(:,2:4)=d(:,2:4)*rotz(30);
hold on
plot3(d(:,2),d(:,3),d(:,4),'r','LineWidth',3);
norm([d(end,2),d(end,3),d(end,4)])
% d = importdata('/Users/lingqiujin/output/vins_result_loop.csv');
% % plot3(d(:,2),d(:,3),d(:,4),'g','LineWidth',3);
% % plot3(d(990:end-90,1),d(990:end-90,2),d(990:end-90,3),'b','LineWidth',3); grid minor
% d(:,2:4)=d(:,2:4)*rotz(30);
% hold on
% plot3(d(:,2),d(:,3),d(:,4),'g','LineWidth',3);
%%
hold on;
d = importdata('/Users/lingqiujin/Data/iphone7_06_04_2019/arkit/arkit_XYZ.txt');
d(:,2:4)=d(:,2:4)*roty(90);
d(:,2:4)=d(:,2:4)*rotz(90);
plot3(d(1546:round(end*.25),2),d(1546:round(end*.25),3),d(1546:round(end*.25),4),'g','LineWidth',3); grid minor;axis equal
%%
d = importdata('/Users/lingqiujin/Data/Trajectory/XYZelevator.txt');
plot3(d(90:end-90,1),d(90:end-90,2),d(90:end-90,3),'b','LineWidth',3); grid minor
%%
d = importdata('/Users/lingqiujin/Data/Trajectory/iphoneX1.txt');
d=d*roty(-97);
figure,plot3(d(90:end-90,1),d(90:end-90,2),d(90:end-90,3),'b','LineWidth',3); grid minor

%%
d = importdata('/Users/lingqiujin/Data/Trajectory/iphoneX2.txt');
% d=d*roty(-97);
plot3(d(90:end-90,1),d(90:end-90,2),d(90:end-90,3),'b','LineWidth',3); grid minor
%%
d = importdata('/Users/lingqiujin/Data/Trajectory/iphoneX3.txt');
% d=d*roty(-97);
plot3(d(90:10000,1),d(90:10000,2),d(90:10000,3),'b','LineWidth',3); grid minor

%%
d = importdata('/Users/lingqiujin/CameraTrajectory.txt');
% d=d*roty(-97);
plot3(d(:,2),d(:,3),d(:,4),'b','LineWidth',3); grid minor
%%
d = importdata('/Users/lingqiujin/Data/iphone7_06_04_2019/2019-06-04T09-55-19/Intrinsic.txt');
mean(d(:,2:5)/3)
%%
close all
clear
d = importdata('/Users/lingqiujin/Data/iphone7_06_04_2019/2019-06-04T09-55-19/XYZ.txt');
% d_one = ones(length(d),1);

% plot3(d(990:end-90,1),d(990:end-90,2),d(990:end-90,3),'b','LineWidth',3); grid minor
% d=d*roty(-63);
plot3(d(190:round(end*.25),2),d(190:round(end*.25),3),d(190:round(end*.25),4),'r','LineWidth',3); grid minor

hold on, plot3(d(round(end*.25):round(end*1),2),d(round(end*.25):round(end*1),3),d(round(end*.25):round(end*1),4),'b','LineWidth',3); grid minor
axis equal

%%
%%
% close all
figure,
clear
d = importdata('/Users/lingqiujin/Data/iphone7_06_04_2019/arkit/arkit_XYZ.txt');
% d_one = ones(length(d),1);

% plot3(d(990:end-90,1),d(990:end-90,2),d(990:end-90,3),'b','LineWidth',3); grid minor
% d=d*roty(-63);
plot3(d(1546:round(end*.25),2),d(1546:round(end*.25),3),d(1546:round(end*.25),4),'r','LineWidth',3); grid minor

hold on, plot3(d(round(end*.25):round(end*1),2),d(round(end*.25):round(end*1),3),d(round(end*.25):round(end*1),4),'b','LineWidth',3); grid minor
axis equal; grid minor
%%
close all
d = importdata('/Users/lingqiujin/output/vins_result_loop.csv');
% d = d-ones(length(d),1)*d(243,:);
% d_one = ones(length(d),1);

% plot3(d(990:end-90,1),d(990:end-90,2),d(990:end-90,3),'b','LineWidth',3); grid minor
% d=d*roty(-63);
plot3(d(243:round(end*.1),2),d(243:round(end*.1),3),d(243:round(end*.1),4),'b','LineWidth',3); grid minor

hold on 
plot3(d(243:round(end*.05),2),d(243:round(end*.05),3),d(243:round(end*.05),4),'r','LineWidth',3); grid minor
hold on 
plot3(d(round(end*.95):round(end*.99),2),d(round(end*.95):round(end*.99),3),d(round(end*.95):round(end*.99),4),'g','LineWidth',3); grid minor

axis equal

%%
close all

d = importdata('/Users/lingqiujin/output/vins_result_no_loop.csv');
plot3(d(1000:end-1900,1),d(1000:end-1900,2),d(1000:end-1900,3),'b','LineWidth',3);
axis equal
hold on, plot3(d(1000:1020,1),d(1000:1020,2),d(1000:1020,3),'r','LineWidth',3);

grid minor
%%
close all

d = importdata('/Users/lingqiujin/Data/iphone7_06_04_2019/vins/XYZ.txt');
plot3(d(700:end,1),d(700:end,2),d(700:end,3),'b','LineWidth',3);
axis equal
hold on, plot3(d(700:720,1),d(700:720,2),d(700:720,3),'r','LineWidth',3);

grid minor

%%
d = importdata('/Users/lingqiujin/output/vins_result_no_loop.csv');plot3(d(300:end-90,2),d(300:end-90,3),d(300:end-90,4),'b','LineWidth',3);axis equal
hold on;plot3(d(765:end-90,2),d(765:end-90,3),d(765:end-90,4),'r','LineWidth',3);
hold on;plot3(d(400:480,2),d(400:480,3),d(400:480,4),'g','LineWidth',3);

mk0 = mean([d(400:480,2),d(400:480,3),d(400:480,4)])

mk1=mean([ d(765:770,2),d(765:770,3),d(765:770,4) ])

mk2=mean([ d(end-3:end,2),d(end-3:end,3),d(end-3:end,4) ])


norm(mk1-mk0)
norm(mk2-mk1)
d1 = [d(1:end-1,2),d(1:end-1,3),d(1:end-1,4)]';
d2 = [d(2:end,2),d(2:end,3),d(2:end,4)]'; 
length = sum(vecnorm(d2-d1))

lll = vecnorm(d2-d1);
figure,plot(lll)

%%
d = importdata('/Users/lingqiujin/Downloads/2019-06-10T11-26-19/vins_result_no_loop.csv');plot3(d(:,2),d(:,3),d(:,4),'b','LineWidth',3);axis equal
hold on
d = importdata('/Users/lingqiujin/Downloads/2019-06-10T11-26-19/vins_result_no_loop_intrin.csv');plot3(d(:,2),d(:,3),d(:,4),'r','LineWidth',3);axis equal

grid minor

% d = importdata('/Users/lingqiujin/Downloads/2019-06-06T13-30-13/2019-06-06T16-57-35/2019-06-07T09-22-44/XYZ.txt');plot3(d(:,2),d(:,3),d(:,4),'r','LineWidth',3);axis equal

%%
clear
clc
MeterToImage = 5.5;%5.3846;

map = imread('/Users/lingqiujin/Data/roi3.png');
% d = importdata('/Users/lingqiujin/output/vins_result_no_loop.csv');
d = importdata('/Users/lingqiujin/Data/06_12_iphone7/2019-06-12T14-08-13/vins_result_no_loop.csv');
dd(:,2:4)=d(:,2:4)*rotz(-38.768985)*rotx(0.0842);
xy = [dd(:,2),dd(:,3)]*MeterToImage;
close all,imshow(map);hold on;plot(104+xy(:,1),390-xy(:,2),'r','LineWidth',3)

clear d
clear dd
d = importdata('/Users/lingqiujin/Data/06_12_iphone7/2019-06-12T14-11-54/vins_result_no_loop.csv');
dd(:,2:4)=d(:,2:4)*rotz(-48.46)*rotx(1.19);
xy = [dd(:,2),dd(:,3)]*MeterToImage;
hold on;plot(104+xy(:,1),390-xy(:,2),'g','LineWidth',3)

clear d
clear dd
d = importdata('/Users/lingqiujin/Data/06_12_iphone7/2019-06-12T14-13-54/vins_result_no_loop.csv');
dd(:,2:4)=d(:,2:4)*rotz(-35)*rotx(2.21);
xy = [dd(:,2),dd(:,3)]*MeterToImage;
hold on;plot(104+xy(:,1),390-xy(:,2),'b','LineWidth',3)
