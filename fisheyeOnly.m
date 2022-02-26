clear 
clc
% close all

titleSize =20;
labelSize =20;
xyzsize = 20;

h = figure('units','normalized','outerposition',[0 0 1 1]);

fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/";


[d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
[length,height] =size(d_ba);
d_ts_buffer = d_ts(1);
subplot(2,2,1)
p1 = plot(d_ts-d_ts_buffer, d_tk(:,2),'LineWidth',5);
% hold on,
% p2 = plot(d_ts-d_ts_buffer, d_tk(:,8),'LineWidth',5);

ylabel("counts",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title( "Feature counts (230 Max)",'FontSize',titleSize,'FontWeight','bold')
% legend([p1 p2],["Detected","# after RANSAC"],'FontSize',20,'Location','NorthEast')

subplot(2,2,3)
p3 = plot(d_ts-d_ts_buffer, d_ba(:,14) ,'LineWidth',5);
% fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/pixel_tum";
% [d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
% d_ts_buffer = d_ts(1);
if height>14
    hold on
    p32 = plot(d_ts-d_ts_buffer, d_ba(:,28) ,'LineWidth',5);
    legend([p3 p32],{'mono','stereo'},'FontSize',30,'Location','Best')
end
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier counts",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("BA inlier",'FontSize',titleSize,'FontWeight','bold')

% fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/angle_tum";
% [d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
subplot(2,2,2)
p3 = plot(d_ts-d_ts_buffer, d_tk(:,8),'LineWidth',5);
xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("tracking counts",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("input number for BA (RANSAC results)",'FontSize',titleSize,'FontWeight','bold')




subplot(2,2,4)

d_ts_buffer = d_ts(1);
hold on
p4 = plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
if height>14
    hold on
    p5 = plot(d_ts-d_ts_buffer, d_ba(:,17),'LineWidth',5);
    legend([p4 p5],{'mono','stereo'},'FontSize',30,'Location','Best')
end
% hold on 
% p4 = plot(d_ts-d_ts_buffer, d_ba(:,8),'g:','LineWidth',5);

xlabel("time (s)",'FontSize',labelSize,'FontWeight','bold')
ylabel("inlier ratio",'FontSize',labelSize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
grid minor
title("mean reprojection error",'FontSize',titleSize,'FontWeight','bold')
% legend([p1 p2],["Mono","Stereo"],'FontSize',20,'Location','NorthEast')


set(gcf,'color','w');
set(gca,'color','w');
% exportgraphics(h,'output/fisheye_tum.png') 
%% difference cost magnitude 
clear
% close all
fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/error";
[d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
d_ts_buffer = d_ts(1);
figure,
subplot(3,1,1)
plot(d_ts-d_ts_buffer, d_ba(:,2),'LineWidth',5);
grid minor
title("unit one difference",'FontSize',20,'FontWeight','bold')
set(gca,'FontSize',20)

subplot(3,1,2)
plot(d_ts-d_ts_buffer, d_ba(:,3),'LineWidth',5);
grid minor
title("pixel distance",'FontSize',20,'FontWeight','bold')
set(gca,'FontSize',20)

subplot(3,1,3)
plot(d_ts-d_ts_buffer, d_ba(:,4),'LineWidth',5);
grid minor
title("tangent distance",'FontSize',20,'FontWeight','bold')

xlabel("time (s)",'FontSize',20,'FontWeight','bold')

set(gca,'FontSize',20)
