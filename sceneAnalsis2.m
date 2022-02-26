clear 
clc

titleSize =20;
labelSize =20;
xyzsize = 20;
% # rural_follow_passage
% # rural_follow_wall
% # rural_straight
% # rural_turn
% # rural_turn_wall
base_dir = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/Results/rural_turn/";

cameraSetUp = ["top" "down/t265" "up/t265" "down/d455" "up/d455" ];
stepN = 1; % frame rate,1 means max frame rate
cutN = 1; % resolution, 2 means 1/2 resolution
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);

%% up or down t265
h = figure('units','normalized','outerposition',[0 0 1 1]);
full_path1 = base_dir+cameraSetUp(2)+cameraSetting;
full_path2 = base_dir+cameraSetUp(3)+cameraSetting;

[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

d_ts_buffer = d_ts_buffer+1.7;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path2);
% d_ts_buffer = d_ts(1);
subplot(2,2,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

subplot(2,2,1)

% xlim([0,t_max])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')
legend([p1 p2],["t265 down","t265 up"],'FontSize',30,'Location','Best')



subplot(2,2,2)
% xlim([0,t_max])
% xlabel("time",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')


subplot(2,2,3)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error mono",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,4)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error stereo",'FontSize',titleSize,'FontWeight','bold')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/t265_step1_cut1.png') 

%% up or down d455
h = figure('units','normalized','outerposition',[0 0 1 1]);
full_path1 = base_dir+cameraSetUp(4)+cameraSetting;
full_path2 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts1,d_ls,d_tk,d_ba] = loadData(full_path1);
[d_ts2,d_ls,d_tk,d_ba] = loadData(full_path2);
d_ts_buffer = min (min(d_ts1),min(d_ts2));
t_max = min (max(d_ts1),max(d_ts2)) - d_ts_buffer;

[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

d_ts_buffer = d_ts_buffer+1.7;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path2);
% d_ts_buffer = d_ts(1);
subplot(2,2,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

subplot(2,2,1)

% xlim([0,t_max])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,2)
% xlim([0,t_max])
% xlabel("time",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')


subplot(2,2,3)
% xlim([0,t_max]);grid minor
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error mono",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,4)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error stereo",'FontSize',titleSize,'FontWeight','bold')
legend([p1 p2],["d455 down","d455 up"],'FontSize',30,'Location','Best')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/d455_step1_cut1.png') 
%% According to the results from last sessions, up is better
%% up t265 or up 455 or top
h = figure('units','normalized','outerposition',[0 0 1 1]);

stepN = 1; % frame rate,1 means max frame rate
cutN = 1; % resolution, 2 means 1/2 resolution
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);

full_path1 = base_dir+cameraSetUp(1)+cameraSetting;
full_path2 = base_dir+cameraSetUp(3)+cameraSetting;
full_path3 = base_dir+cameraSetUp(5)+cameraSetting;




[d_ts1,d_ls,d_tk,d_ba] = loadData(full_path1);
d_ts_buffer = min(d_ts1);
t_max = max(d_ts1) - d_ts_buffer;

[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
d_ts_buffer = d_ts(1);
subplot(3,1,1)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'Color',[0, 0.4470, 0.7410],'LineWidth',5);
subplot(3,1,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'Color',[0, 0.4470, 0.7410],'LineWidth',5);
subplot(3,1,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3)/3,'Color',[0, 0.4470, 0.7410],'LineWidth',5);
% compensate for the large resolution

[d_ts,d_ls,d_tk,d_ba] = loadData(full_path2);
subplot(3,1,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'Color',[0.8500, 0.3250, 0.0980],'LineWidth',5);
subplot(3,1,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'Color',[0.8500, 0.3250, 0.0980],'LineWidth',5);
subplot(3,1,3)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,3),'Color',[0.8500, 0.3250, 0.0980],'LineWidth',5);

[d_ts,d_ls,d_tk,d_ba] = loadData(full_path3);
subplot(3,1,1)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'Color',[0.9290, 0.6940, 0.1250],'LineWidth',5);
subplot(3,1,2)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'Color',[0.9290, 0.6940, 0.1250],'LineWidth',5);
subplot(3,1,3)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,3),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',5);

subplot(3,1,1)
% xlim([0,t_max])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')


subplot(3,1,2)
% xlim([0,t_max])
% xlabel("time",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')


subplot(3,1,3)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error mono",'FontSize',titleSize,'FontWeight','bold')

legend([p1 p2 p3],["fisheye","t265","d455"],'FontSize',20,'Location','Best')

set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/fisheye_t265_d455.png') 


%% runtime tradeoff
%% frame rate and resolution t265 up

h = figure('units','normalized','outerposition',[0 0 1 1]);
stepN = 1; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
d_ts_buffer = min(d_ts);
t_max = max(d_ts) - d_ts_buffer;
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);


stepN = 1; cutN = 2; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p2 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p2 = plot(d_ts-d_ts_buffer, 2*d_ba(:,8),'LineWidth',5);

stepN = 2; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

stepN = 2; cutN = 2; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p4 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p4 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p4 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p4 = plot(d_ts-d_ts_buffer, 2*d_ba(:,8),'LineWidth',5);

stepN = 3; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

stepN = 3; cutN = 2; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p6 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p6 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p6 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p6 = plot(d_ts-d_ts_buffer, 2*d_ba(:,8),'LineWidth',5);

subplot(2,2,1)

% xlim([0,t_max])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,2)
% xlim([0,t_max])
% xlabel("time",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')


subplot(2,2,3)
% xlim([0,t_max])
xlabel("t265 time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error mono",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,4)
% xlim([0,t_max])
xlabel("t265 time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error stereo",'FontSize',titleSize,'FontWeight','bold')
legend([p1 p2 p3 p4 p5 p6],["640@30Hz","320@30Hz","640@15Hz","320@15Hz","640@10Hz","320@10Hz"],'FontSize',20,'Location','Best')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/t265_framerate_res.png') 

%% frame rate and resolution d455 up
h = figure('units','normalized','outerposition',[0 0 1 1]);
stepN = 1; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
d_ts_buffer = min(d_ts);
t_max = max(d_ts) - d_ts_buffer;
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);


stepN = 1; cutN = 2; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p2 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p2 = plot(d_ts-d_ts_buffer, 2*d_ba(:,8),'LineWidth',5);

stepN = 2; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

stepN = 2; cutN = 2; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p4 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p4 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p4 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p4 = plot(d_ts-d_ts_buffer, 2*d_ba(:,8),'LineWidth',5);

stepN = 3; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

stepN = 3; cutN = 2; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,1)
hold on,p6 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(2,2,2)
hold on,p6 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(2,2,3)
hold on,p6 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);
subplot(2,2,4)
hold on,p6 = plot(d_ts-d_ts_buffer, 2*d_ba(:,8),'LineWidth',5);

subplot(2,2,1)

% xlim([0,t_max])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,2)
% xlim([0,t_max])
% xlabel("time",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')


subplot(2,2,3)
% xlim([0,t_max])
xlabel("d455 time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error mono",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,4)
% xlim([0,t_max])
xlabel("d455 time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error stereo",'FontSize',titleSize,'FontWeight','bold')
legend([p1 p2 p3 p4 p5 p6],["640@30Hz","320@30Hz","640@15Hz","320@15Hz","640@10Hz","320@10Hz"],'FontSize',20,'Location','Best')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/d455_framerate_res.png') 

%% frame rate and resolution fisheye top
h = figure('units','normalized','outerposition',[0 0 1 1]);
stepN = 1; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(1)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
d_ts_buffer = min(d_ts);
t_max = max(d_ts) - d_ts_buffer;
d_ts_buffer = d_ts(1);
subplot(3,1,1)
p1 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(3,1,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(3,1,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);


stepN = 1; cutN = 2; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(1)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(3,1,1)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(3,1,2)
hold on,p2 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(3,1,3)
hold on,p2 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);

stepN = 1; cutN = 3; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(1)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(3,1,1)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(3,1,2)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(3,1,3)
hold on,p3 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);

stepN = 2; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(1)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(3,1,1)
hold on,p4 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(3,1,2)
hold on,p4 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(3,1,3)
hold on,p4 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);

stepN = 2; cutN = 2; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(1)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(3,1,1)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(3,1,2)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(3,1,3)
hold on,p5 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);

stepN = 2; cutN = 3; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(1)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(3,1,1)
hold on,p6 = plot(d_ts-d_ts_buffer, d_ls(:,10) ./ 150,'LineWidth',5);
subplot(3,1,2)
hold on,p6 = plot(d_ts-d_ts_buffer, d_ba(:,5) ./ 150,'LineWidth',5);
subplot(3,1,3)
hold on,p6 = plot(d_ts-d_ts_buffer, 2*d_ba(:,3),'LineWidth',5);

subplot(3,1,1)

% xlim([0,t_max])
% xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("feature tracking rate after 10 tracks",'FontSize',titleSize,'FontWeight','bold')

subplot(3,1,2)
% xlim([0,t_max])
% xlabel("time",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("inlier rate between neighbor frames",'FontSize',titleSize,'FontWeight','bold')


subplot(3,1,3)
% xlim([0,t_max])
xlabel("fisheye time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error mono",'FontSize',titleSize,'FontWeight','bold')

legend([p1 p2 p3 p4 p5 p6],["1920@15Hz","960@15Hz","480@15Hz","1920@7.5Hz","960@7.5Hz","480@7.5Hz"],'FontSize',20,'Location','Best')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/fisheye_framerate_res.png') 

%% compare stereo vs mono
%% t265 
h = figure('units','normalized','outerposition',[0 0 1 1]);
stepN = 1; cutN = 1; 
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
d_ts_buffer = min(d_ts);
t_max = max(d_ts) - d_ts_buffer;
d_ts_buffer = d_ts(1);
subplot(2,2,1)
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(2)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);

cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(4)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,2)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);

cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,3)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);

cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,4)
p1 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);

subplot(2,2,1)
cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(2)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
hold on, p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(4)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,2)
hold on, p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(3)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,3)
hold on, p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);

cameraSetting = "/cut"+num2str(cutN)+"_step"+num2str(stepN);
full_path1 = base_dir+cameraSetUp(5)+cameraSetting;
[d_ts,d_ls,d_tk,d_ba] = loadData(full_path1);
subplot(2,2,4)
hold on, p2 = plot(d_ts-d_ts_buffer, d_ba(:,8),'LineWidth',5);


subplot(2,2,1)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("Up",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error t265",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,2)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error d455",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,3)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("Down",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
% title("mean reprojection error t265",'FontSize',titleSize,'FontWeight','bold')

subplot(2,2,4)
% xlim([0,t_max])
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("pixel distance",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
% title("mean reprojection error d455",'FontSize',titleSize,'FontWeight','bold')

legend([p1 p2],["Mono","Stereo"],'FontSize',20,'Location','Best')
set(gcf,'color','w');
set(gca,'color','w');
exportgraphics(h,'output/mono_stereo.png') 
