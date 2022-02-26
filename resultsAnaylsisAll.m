clear 
clc
close all

titleSize =20;
labelSize =20;
xyzsize = 20;
% short1
% short2
% long1
% long2
idx =3;
datasets = ["short1","short2","long1","long2"];
upAHEADdowns = [2.2,2.18,1.5,1.6];
upAHEADdown = upAHEADdowns(idx);
base_dir = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/Results/all_data/"+datasets(idx);

cameraSetUp = ["/up/t265" "/down/t265" "/up/d455" "/down/d455" "/top" ];
cameraSetting = "/cut1_step1";

%% up or down t265
h = figure('units','normalized','outerposition',[0 0 1 1]);
t265_up = base_dir+cameraSetUp(1)+cameraSetting;
t265_down = base_dir+cameraSetUp(2)+cameraSetting;

[d_ts,d_ls,d_tk,d_ba] = loadData(t265_up);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ d_ls(:,1),'LineWidth',5);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ d_tk(:,2),'LineWidth',5);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

%
[d_ts,d_ls,d_tk,d_ba] = loadData(t265_down);
d_ts_buffer = d_ts(1)+upAHEADdown;
subplot(2,2,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ d_ls(:,1),'LineWidth',5);
subplot(2,2,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ d_tk(:,2),'LineWidth',5);
subplot(2,2,3)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

subplot(2,2,1)

xlim([0,d_ts(end)-d_ts_buffer])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')
legend([p1 p2],["t265 up","t265 down"],'FontSize',30,'Location','Best')

subplot(2,2,2)
xlim([0,d_ts(end)-d_ts_buffer])
% xlabel("time",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')


subplot(2,2,3)
xlim([0,d_ts(end)-d_ts_buffer])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error mono",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,4)
xlim([0,d_ts(end)-d_ts_buffer])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error stereo",'FontSize',titleSize,'FontWeight','bold')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/t265_up_down.png') 

%% up or down d455
h = figure('units','normalized','outerposition',[0 0 1 1]);
d455_up = base_dir+cameraSetUp(3)+cameraSetting;
d455_down = base_dir+cameraSetUp(4)+cameraSetting;

[d_ts,d_ls,d_tk,d_ba] = loadData(d455_up);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ d_ls(:,1),'LineWidth',5);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ d_tk(:,2),'LineWidth',5);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

%
[d_ts,d_ls,d_tk,d_ba] = loadData(d455_down);
d_ts_buffer = d_ts(1)+upAHEADdown;
subplot(2,2,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ d_ls(:,1),'LineWidth',5);
subplot(2,2,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ d_tk(:,2),'LineWidth',5);
subplot(2,2,3)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

subplot(2,2,1)

xlim([0,d_ts(end)-d_ts_buffer])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')
legend([p1 p2],["d455 up","d455 down"],'FontSize',30,'Location','Best')

subplot(2,2,2)
xlim([0,d_ts(end)-d_ts_buffer])
% xlabel("time",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')


subplot(2,2,3)
xlim([0,d_ts(end)-d_ts_buffer])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error mono",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,4)
xlim([0,d_ts(end)-d_ts_buffer])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error stereo",'FontSize',titleSize,'FontWeight','bold')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/d455_up_down.png') 


%% According to the results from last sessions, up is better
%% up t265 or up 455 or top
h = figure('units','normalized','outerposition',[0 0 1 1]);

t265_up = base_dir+cameraSetUp(1)+cameraSetting;
d455_up = base_dir+cameraSetUp(3)+cameraSetting;
fisheye = base_dir+cameraSetUp(5)+cameraSetting;


[d_ts,d_ls,d_tk,d_ba] = loadData(t265_up);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_tk(:,2),'LineWidth',5);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_tk(:,8),'LineWidth',5);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ d_ls(:,1),'LineWidth',5);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ d_tk(:,2),'LineWidth',5);

[d_ts,d_ls,d_tk,d_ba] = loadData(d455_up);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_tk(:,2),'LineWidth',5);
subplot(2,2,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_tk(:,8),'LineWidth',5);
subplot(2,2,3)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ d_ls(:,1),'LineWidth',5);
subplot(2,2,4)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ d_tk(:,2),'LineWidth',5);


[d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
hold on,p3 = plot(d_ts-d_ts_buffer, d_tk(:,2),':','LineWidth',5);
subplot(2,2,2)
hold on,p3 = plot(d_ts-d_ts_buffer, d_tk(:,8),'LineWidth',5);
subplot(2,2,3)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ d_ls(:,1),'LineWidth',5);
subplot(2,2,4)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ d_tk(:,2),'LineWidth',5);


subplot(2,2,1)
% xlim([0,t_max])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("number",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("Detected Features (150 Max)",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,2)
ylabel("number",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("After RANSAC Features number",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,3)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')


subplot(2,2,4)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')




legend([p1 p2 p3],["t265","d455","fisheye"],'FontSize',20,'Location','Best')

set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/t265_d455_fisheye.png') 



%% compare stereo vs mono
%% t265 
h = figure('units','normalized','outerposition',[0 0 1 1]);

t265_up = base_dir+cameraSetUp(1)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(t265_up);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',4);
hold on
p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',4);


t265_down = base_dir+cameraSetUp(2)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(t265_down);
d_ts_buffer = d_ts(1);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',4);
hold on
p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',4);


d455_up = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(d455_up);
d_ts_buffer = d_ts(1);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',4);
hold on
p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',4);


d455_down = base_dir+cameraSetUp(4)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(d455_down);
d_ts_buffer = d_ts(1);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
hold on
p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);


subplot(2,2,1)
% xlim([0,t_max])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("Up",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("t265 mean reprojection error",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,2)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
% ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("D455 mean reprojection error",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,3)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("Down",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
ylabel("Down",'FontSize',labelSize,'FontWeight','bold')

subplot(2,2,4)
set(gca,'FontSize',xyzsize)
grid minor
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')

legend([p1 p2],["Mono","Stereo"],'FontSize',20,'Location','Best')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/mono_stereo.png') 
%%
% close all